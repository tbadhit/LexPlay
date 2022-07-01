//
//  UserRepository.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 29/06/22.
//

import Foundation

protocol UserRepositoryProtocol {
    func getActiveUser() -> UserEntity?
}

class UserRepository {
    private let persistenceController = PersistenceController.shared
    private let context = PersistenceController.shared.container.viewContext
  
  init() {
      let avatar = AvatarEntity(context: context)
      avatar.uuid = UUID()
      avatar.path = "lex"
      let reminder = ReminderEntity(context: context)
      reminder.uuid = UUID()
      reminder.time = Date()
      let user = UserEntity(context: context)
      user.uuid = UUID()
      user.name = "Invoker"
      user.alphabets = []
      user.avatar = avatar
      user.reminder = reminder
      save()
  }

    private func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

extension UserRepository: UserRepositoryProtocol {
    func getActiveUser() -> UserEntity? {
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(UserEntity.login), NSNumber(value: true))
        return try? context.fetch(request).first
    }
  
    
}
