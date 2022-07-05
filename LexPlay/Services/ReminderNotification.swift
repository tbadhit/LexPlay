//
//  ReminderNotification.swift
//  LexPlay
//
//  Created by erlina ng on 28/06/22.
//

import Foundation
import UserNotifications
import SwiftUI

var delegate = NotificationDelegate()

class ReminderNotification {
    private var reminderRepository: ReminderRepositoryProtocol
    private var user: UserEntity
    
    init(user: UserEntity = UserRepository().getActiveUser()!, reminderRepository: ReminderRepositoryProtocol = ReminderRepository()) {
        self.user = user
        self.reminderRepository = reminderRepository
    }
    
    private func addNotification (entity: ReminderEntity, currentDate: Date) {
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
        
        let request = UNNotificationRequest(identifier: "reminder:\(entity.user?.uuid?.uuidString ?? UUID().uuidString)",  content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        entity.notifId = request.identifier
        reminderRepository.update(reminder: entity, isActive: true, time: currentDate)
    }
    
    private func removeNotification(entity: ReminderEntity) {
        if let notifId = entity.notifId {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notifId])
        }
        entity.notifId = nil
        reminderRepository.update(reminder: entity, isActive: false, time: nil)
    }
}

extension ReminderNotification {
    func getPredicate() -> FetchRequest<ReminderEntity> {
        return FetchRequest<ReminderEntity>(sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", #keyPath(ReminderEntity.uuid), user.reminder!.uuid! as CVarArg))
    }
    
    func toggleNotification(entity: ReminderEntity, time: Date, isActive: Bool) {
        if isActive {
            addNotification(entity: entity, currentDate: time)
        } else {
            removeNotification(entity: entity)
        }
    }
}

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.badge, .banner, .sound])
    }
}
