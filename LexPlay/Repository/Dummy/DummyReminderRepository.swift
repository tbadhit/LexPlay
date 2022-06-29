//
//  DummyReminderRepository.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 29/06/22.
//

import Foundation
import SwiftUI

class DummyReminderRepository {
    private let context = PersistenceController.preview.container.viewContext
    
    private func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

extension DummyReminderRepository: ReminderRepositoryProtocol {
    func update(reminder: ReminderEntity, isActive: Bool, time: Date) {
        if isActive {
            reminder.time = time
        }
        reminder.active = isActive
        save()
    }
    
    func get(user: UserEntity) -> ReminderEntity {
        let request = ReminderEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ReminderEntity.user.uuid), user.uuid! as CVarArg)
        return try! context.fetch(request).first!
    }
    
    func getPredicate(user: UserEntity) -> FetchRequest<ReminderEntity> {
        return FetchRequest<ReminderEntity>(sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", #keyPath(ReminderEntity.uuid), user.reminder!.uuid! as CVarArg))
    }
    
    func getAll() -> [ReminderEntity] {
        return try! context.fetch(ReminderEntity.fetchRequest())
    }
}
