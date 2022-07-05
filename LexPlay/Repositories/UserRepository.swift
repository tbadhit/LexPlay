//
//  UserRepository.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 29/06/22.
//

import Foundation
import CoreData

protocol UserRepositoryProtocol {
    func getActiveUser() -> UserEntity?
    func addUser(name : String, avatar : AvatarEntity)
    func addUser(user: UserModel)
    func editUsername( name : String, user : UserEntity)
}

class UserRepository {
    private let context: NSManagedObjectContext
    
    init (viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = viewContext
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
    
    let reminder = ReminderEntity(context: context)
            reminder.uuid = UUID()
            reminder.time = Date()
    
    let userEntity = UserEntity(context: context)
    userEntity.name = user.name
    userEntity.avatar = user.avatar
    userEntity.uuid = UUID()
    userEntity.reminder = reminder
    
    save()
  }
  
    func getActiveUser() -> UserEntity? {
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(UserEntity.login), NSNumber(value: true))
        return try? context.fetch(request).first
    }
    
    func addUser (name : String, avatar : AvatarEntity) {
        let reminder = ReminderEntity(context: context)
                reminder.uuid = UUID()
                reminder.time = Date()
        
        //1. create new NSManageobject
        let newUser = UserEntity(context: context)
        
        //2. add/ update the attributes
      newUser.uuid = UUID()
        newUser.name = name
        newUser.avatar = avatar
        newUser.reminder = reminder
        newUser.alphabets = []
        
        //3. save context
        save()
    }
    
    func editUsername( name : String, user : UserEntity) {
        //1. Change Value
        user.name = name
        
        //2. save context
        save()
    }
}
