import UserNotifications

struct Notification {
    var id: String
    var title: String
}

class LocalNotificationManager {
    var notifications = [Notification]()
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
            }
    }
    
    
    func addNotification(title: String) -> Void {
        notifications.append(Notification(id: UUID().uuidString, title: title))
    }
    
    func scheduleNotifications(date: DateComponents) -> [Notification] {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            
            // after 5 seconds
            // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            /*
            var date = DateComponents()
            date.hour = 11
            date.minute = 10
             */
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            print("Next trigger Date \(String(describing: trigger.nextTriggerDate()))")
            
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
                
            }
        }
        
        return notifications
    }
}



