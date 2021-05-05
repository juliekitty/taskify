//
//  tasksViewModel.swift
//  taskify
//
//  Created by Julie Landry on 03.05.21.
//

import SwiftUI

class TasksViewModel: ObservableObject {
    @Published var tasks: [Task] = [Task]()
    
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
    
    
    func addTask(newTask: Task) {
        self.tasks.append(newTask)
        
    }
}
