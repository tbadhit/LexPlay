//
//  UserRepository.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 29/06/22.
//

import Foundation

protocol UserRepositoryProtocol {
    func getActiveUser() -> UserEntity?
    func addUser(name : String, login: Bool, timeStamp : TimeInterval)
    func editUsername( name : String, user : UserEntity)
}

class UserRepository {
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

extension UserRepository: UserRepositoryProtocol {
    func getActiveUser() -> UserEntity? {
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(UserEntity.login), NSNumber(value: true))
        return try? context.fetch(request).first
    }
    
    func addUser (name : String, login: Bool, timeStamp : TimeInterval) {
        //1. create new NSManageobject
        let newUser = UserEntity(context: context)
        
        //2. add/ update the attributes
        newUser.name = name
        newUser.login = login
        newUser.timestamp = timeStamp
        
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
