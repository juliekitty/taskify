//
//  Task.swift
//  taskify
//
//  Created by Julie Landry on 03.05.21.
//

import Foundation

class  Task: Identifiable {
    let ID: UUID = UUID()
    let label: String
    let startDateTime: Date
    var recurring: Set<Weekday> = Set<Weekday>()
    var subtasks: [SubTask]
    
    enum Weekday: String   {
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
    case Sunday = "Sunday"
    }
    
    init(label: String, timeStamp: Date) {
        self.label = label
        self.startDateTime = timeStamp
        self.subtasks = []
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
    
    func addRecurring(weekdays: [Weekday]) -> Void {
        
        for weekday in weekdays {
            self.recurring.insert(weekday)
        }
        // return self.subtasks
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
