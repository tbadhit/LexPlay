//
//  UserRepository.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 29/06/22.
//

import CoreData
import Foundation
import SwiftUI

protocol UserRepositoryProtocol {
    func getActiveUser() -> UserEntity?
    func addUser(name: String, avatar: AvatarEntity, isLearnCustomLesson: Bool)
    func addUser(user: UserModel)
    func editUser(name: String, avatar: AvatarEntity, user: UserEntity)
    static func getActiveUserPredicate() -> FetchRequest<UserEntity>
}

class UserRepository {
    private let context: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        context = viewContext
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
    func addUser(user: UserModel) {
        guard let avatar = user.avatar else { return }
        addUser(name: user.name, avatar: avatar, isLearnCustomLesson: user.isLearnCustomLesson)
    }

    func getActiveUser() -> UserEntity? {
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(UserEntity.login), NSNumber(value: true))
        return try? context.fetch(request).first
    }

    func addUser(name: String, avatar: AvatarEntity, isLearnCustomLesson: Bool) {
        let reminder = ReminderEntity(context: context)
        reminder.uuid = UUID()
        reminder.time = Date()
        reminder.timestamp = Date().timeIntervalSince1970

        // 1. create new NSManageobject
        let newUser = UserEntity(context: context)

        // 2. add/ update the attributes
        newUser.uuid = UUID()
        newUser.name = name
        newUser.avatar = avatar
        newUser.isLearnCustomLesson = isLearnCustomLesson
        newUser.reminder = reminder
        newUser.alphabets = []
        newUser.timestamp = Date().timeIntervalSince1970

        // 3. save context
        save()
    }

    func editUser(name: String, avatar: AvatarEntity, user: UserEntity) {
        // 1. Change Value
        user.name = name
        user.avatar = avatar

        // 2. save context
        save()
    }
    
    static func getActiveUserPredicate() -> FetchRequest<UserEntity> {
        return FetchRequest<UserEntity>(sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", #keyPath(UserEntity.login), NSNumber(value: true)))
    }
}
