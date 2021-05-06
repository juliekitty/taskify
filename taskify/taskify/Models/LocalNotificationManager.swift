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

    func scheduleNotification(title: String, date: DateComponents) -> Void {
        
        let notification = Notification(id: UUID().uuidString, title: title)
        
        notifications.append(notification)

        let content = UNMutableNotificationContent()
        content.title = notification.title
        
        // WARNING: only for testing
        /*
        // after n seconds
        let triggerInterval = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        print("\nNext trigger Date for testing interval \(String(describing: triggerInterval.nextTriggerDate()))")

        let requestInterval = UNNotificationRequest(identifier: notification.id, content: content,
           trigger:triggerInterval)

        UNUserNotificationCenter.current().add(requestInterval){ error in
            guard error == nil else { return }
         }
        // End after n seconds
        */
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        print("\nNext trigger Date \(String(describing: trigger.nextTriggerDate()))")
        
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            guard error == nil else { return }
        }
    }
    
    

}



