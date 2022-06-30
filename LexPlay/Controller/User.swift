//
//  User.swift
//  LexPlay
//
//  Created by erlina ng on 29/06/22.
//

import Foundation
import CoreData



class User {
    
    func addUser(name : String, login: Bool, timeStamp : TimeInterval, moc: NSManagedObjectContext) {
        //TODO: handle save: save data to the core data
        //1. create new NSManageobject
        let newUser = UserEntity(context: moc)
        
        //2. add/ update the attributes
        newUser.name = name
        newUser.login = login
        newUser.timestamp = timeStamp
        
        //3. save context
        try? moc.save()
        print("YES")
    }
    
    func editUsername( name : String, user : UserEntity, moc: NSManagedObjectContext) {
        user.name = name
        try? moc.save()
    }
}

