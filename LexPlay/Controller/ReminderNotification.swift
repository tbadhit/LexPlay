//
//  ReminderNotification.swift
//  LexPlay
//
//  Created by erlina ng on 28/06/22.
//

import Foundation
import UserNotifications

var delegate = NotificationDelegate()

class ReminderNotification {
    func addNotification (currentDate: Date) {
        UNUserNotificationCenter.current().delegate = delegate
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("all set")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "🤓 Hey!! Lex & Play here!!"
        content.subtitle = "Ayok jangan lupa belajar"
        content.sound = UNNotificationSound.default
        
        let comps = Calendar.current.dateComponents([.hour, .minute], from: currentDate)

        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,  content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.badge, .banner, .sound])
    }


}
