//
//  ReminderRepository.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 29/06/22.
//

import Foundation
import SwiftUI

protocol ReminderRepositoryProtocol {
    func update(reminder: ReminderEntity, isActive: Bool, time: Date)
    func get(user: UserEntity) -> ReminderEntity
    func getPredicate(user: UserEntity) -> FetchRequest<ReminderEntity>
    func getAll() -> [ReminderEntity]
}

class ReminderRepository {
    private let persistenceController = PersistenceController.shared
    private let context = PersistenceController.shared.container.viewContext
    
    private func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

extension ReminderRepository: ReminderRepositoryProtocol {
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
