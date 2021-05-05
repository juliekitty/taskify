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
    let startDateTime: Date
    var recurring: [Bool] = [false, false, false, false, false, false, false] // sunday, monday, tuesday, wednesday, thursday, friday, saturday
    var subtasks: [SubTask]
    
    init(label: String, timeStamp: Date, recurring: [Bool]) {
        self.label = label
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
    
    func addNotification() -> Void {
        let manager = LocalNotificationManager()
        manager.requestPermission()
        for (index, weekday) in self.recurring.enumerated() {
            if (weekday) {
                print("add notification on \(weekdays[index])")
                
                manager.addNotification(title: self.label)
             
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
                
                print("dateTimeComponents \(dateTimeComponents)")

                var dateComponents = DateComponents()
                dateComponents.weekday = index+1 // 1 = Sunday
                dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
                dateComponents.hour = dateTimeComponents.hour
                dateComponents.minute = dateTimeComponents.minute
                
                _ = manager.scheduleNotifications(date: dateComponents)
                                
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
