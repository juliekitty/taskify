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
        
        
        let morning: Task = Task(label: "Prepare for school", timeStamp: Date()-15*86400)
        morning.addSubtask(newTask: SubTask(
                            label: "Dress up",
                            duration: 3))
        morning.addSubtask(newTask: SubTask(
                            label: "Eat your breakfast",
                            duration: 3))
        morning.addSubtask(newTask: SubTask(
                            label: "Tooth brushing",
                            duration: 3))
        
        morning.addRecurring(weekdays: [.Monday, .Tuesday, .Wednesday, .Thursday, .Friday])
        
        let bedtime: Task = Task(label: "Go to bed Routine", timeStamp: Date()-15*86400)
        bedtime.addSubtask(newTask: SubTask(
                            label: "Check your schoolbag",
                            duration: 3))
        bedtime.addSubtask(newTask: SubTask(
                            label: "Put your pyjama on",
                            duration: 3))
        bedtime.addSubtask(newTask: SubTask(
                            label: "Tooth brushing",
                            duration: 3))
        
        bedtime.addRecurring(weekdays: [.Monday, .Tuesday, .Wednesday, .Thursday])
                
        let sampleTasks = [morning,
                           bedtime,
        ]
        
        return sampleTasks
    }
    
    
    func addTask(newTask: Task) -> [Task] {
        self.tasks.append(newTask)
        return self.tasks
    }
}
