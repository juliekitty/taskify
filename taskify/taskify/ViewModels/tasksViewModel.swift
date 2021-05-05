//
//  tasksViewModel.swift
//  taskify
//
//  Created by Julie Landry on 03.05.21.
//

import SwiftUI

class User: Codable {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
}


struct MyDataObject: Codable {
    let name: String
    let age: Int
    let num: Double
    let onOff: Bool
    let date: Date
    let user: User
}


class TasksViewModel: ObservableObject {
    @Published var tasks: [Task] = [Task]()
    
    @AppStorage("tasks") private var dataForAppStorage: Data = Data()
    @State private var dataObjectFromAppStorage: MyDataObject? // = MyDataObject()
    @State private var dataReadFromAppStorage: Bool = false

    internal init() {
        self.tasks = fillTasks()
    }
    private func fillTasks() -> [Task] {
        
        let morningDateTime = Date.from(year: 2021, month: 05, day: 05, hour: 7, minute: 30)
        
        
        let morning: Task = Task(label: "Prepare for school", timeStamp: morningDateTime!, recurring: [false, true, true, true, true, true, false])
        morning.addSubtask(newTask: SubTask(
                            label: "Dress up",
                            duration: 3))
        morning.addSubtask(newTask: SubTask(
                            label: "Eat your breakfast",
                            duration: 3))
        morning.addSubtask(newTask: SubTask(
                            label: "Tooth brushing",
                            duration: 3))
        
        
        let bedtimeDateTime = Date.from(year: 2021, month: 05, day: 05, hour: 20, minute: 00)
        
        let bedtime: Task = Task(label: "Go to bed Routine", timeStamp: bedtimeDateTime!, recurring: [false, true, true, true, true, false, false])
        bedtime.addSubtask(newTask: SubTask(
                            label: "Check your schoolbag",
                            duration: 3))
        bedtime.addSubtask(newTask: SubTask(
                            label: "Put your pyjama on",
                            duration: 3))
        bedtime.addSubtask(newTask: SubTask(
                            label: "Tooth brushing",
                            duration: 3))
        
        let sampleTasks = [morning,
                           bedtime,
        ]
        
        return sampleTasks
    }
    
    func readData() {
        guard let loadedDataObject = try?  JSONDecoder().decode(MyDataObject.self, from: dataForAppStorage) else { return }
        
        dataReadFromAppStorage = true
        dataObjectFromAppStorage = loadedDataObject
    }
    
    func storeData() {
        let user = User(name: "Tom", age: 0)
        let dataToSave: MyDataObject = MyDataObject(name: "Uwe", age: 12, num: 3.4, onOff: false, date: Date(), user: user)

        guard let dataToSaveData: Data = try? JSONEncoder().encode(dataToSave) else { return }
        self.dataForAppStorage = dataToSaveData
    }
    
    func addTask(newTask: Task) {
        self.tasks.append(newTask)
        
    }
}
