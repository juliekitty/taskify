//
//  Task.swift
//  taskify
//
//  Created by Julie Landry on 03.05.21.
//

import Foundation

let weekdays: [String]  = ["Monday", "Tuesday", "Wednesday", "Thursday","Friday","Saturday","Sunday"]


class  Task: Identifiable {
    let ID: UUID = UUID()
    let label: String
    let startDateTime: Date
    var recurring: [Bool] = [false, false, false, false,false,false,false]
    var subtasks: [SubTask]
    
    
    init(label: String, timeStamp: Date) {
        self.label = label
        self.startDateTime = timeStamp
        self.subtasks = []
    }
    
    func displayRecurring() -> String {
        var returnStr: String = ""
        if (self.recurring == [false, false, false, false,false,false,false]) {
            returnStr = "none"
        } else if (self.recurring == [true, true, true, true,true,false,false]) {
            returnStr = "every weekday" // en semaine
        } else if (self.recurring == [true, true, true, true,true,true,true]) {
            returnStr = "everyday" // tous les jours
        } else if (self.recurring == [false, false, false, false,false,true,true]) {
            returnStr = "on the week-end" // les week ends
        } else {
            for (index, element) in self.recurring.enumerated() {
                if (element) {
                    returnStr = returnStr + " " + weekdays[index]
                }
            }            
        }
        return returnStr
    }
    
    func convertDateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func addSubtask(newTask: SubTask) -> Void {
        self.subtasks.append(newTask)
        // return self.subtasks
    }
    
    func addRecurring(weekdays: [Bool]) -> Void {
        
        self.recurring = weekdays
    }
}


class SubTask: Identifiable {
    let label: String
    let duration: Int
    init(label: String, duration: Int) {
        self.label = label
        self.duration = duration
    }
}
