//
//  Task.swift
//  taskify
//
//  Created by Julie Landry on 03.05.21.
//

import Foundation

let weekdays: [String]  = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

class Task: Identifiable, Codable {
    var ID: UUID = UUID()
    let label: String
    let description: String
    let startDateTime: Date
    var recurring: [Bool] = [false, false, false, false, false, false, false] // sunday, monday, tuesday, wednesday, thursday, friday, saturday
    var subtasks: [SubTask]
    
    init(label: String, timeStamp: Date, recurring: [Bool], description: String) {
        self.label = label
        self.description = description
        self.startDateTime = timeStamp
        self.subtasks = []
        self.recurring = recurring
        addNotification()
    }
    
    func displayRecurring() -> String {
        var returnStr: String = ""
        if (self.recurring == [false, false, false, false, false, false, false]) {
            returnStr = "none"
        } else if (self.recurring == [false, true, true, true, true, true, false]) {
            returnStr = "every weekday" // en semaine
        } else if (self.recurring == [true, true, true, true, true, true, true]) {
            returnStr = "everyday" // tous les jours
        } else if (self.recurring == [true, false, false, false, false, false, true]) {
            returnStr = "on the week-end" // les week ends
        } else {
            for (index, element) in self.recurring.enumerated() {
                if (element) {
                    returnStr = returnStr + " " + weekdays[index] + ","
                }
            }
            returnStr = "every" + returnStr.dropLast()       
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
    
    func addNotification() -> Void {
        let manager = LocalNotificationManager()
        manager.requestPermission()
        
        if self.recurring.allSatisfy({ $0 == false }) {
            
            print("\nadd unique notification on \(startDateTime)")
                        
            // get the user's calendar
            let userCalendar = Calendar.current
            
            // choose which date and time components are needed
            let requestedComponents: Set<Calendar.Component> = [
                .year,
                .month,
                .day,
                .hour,
                .minute
            ]
            
            let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: startDateTime)
            
            var dateComponents = DateComponents()
            dateComponents.timeZone = TimeZone.current
            dateComponents.year = dateTimeComponents.year
            dateComponents.month = dateTimeComponents.month
            dateComponents.day = dateTimeComponents.day
            dateComponents.hour = dateTimeComponents.hour
            dateComponents.minute = dateTimeComponents.minute
            manager.scheduleNotification(title: self.label, date: dateComponents)

        } else {
            
            for (index, weekday) in self.recurring.enumerated() {
                if (weekday) {
                    print("\nadd notification on \(weekdays[index])")
                    
                    // get the user's calendar
                    let userCalendar = Calendar.current
                    
                    // choose which date and time components are needed
                    let requestedComponents: Set<Calendar.Component> = [
                        .year,
                        .month,
                        .day,
                        .timeZone,
                        .hour,
                        .minute,
                        .weekday
                    ]
                    
                    let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: startDateTime)
                    
                    var dateComponents = DateComponents()
                    dateComponents.weekday = index+1
                    dateComponents.timeZone = dateTimeComponents.timeZone
                    dateComponents.hour = dateTimeComponents.hour
                    dateComponents.minute = dateTimeComponents.minute
                    manager.scheduleNotification(title: self.label, date: dateComponents)
                }
            }
        }
        
    }
}


class SubTask: Identifiable, Codable {
    let label: String
    let duration: Int
    init(label: String, duration: Int) {
        self.label = label
        self.duration = duration
    }
}
