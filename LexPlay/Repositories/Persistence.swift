//
//  Persistence.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 25/06/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0 ..< 10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }

//        Add new User
        let avatar = AvatarEntity(context: viewContext)
        avatar.uuid = UUID()
        avatar.path = "lex"
        let reminder = ReminderEntity(context: viewContext)
        reminder.uuid = UUID()
        reminder.time = Date()
        let user = UserEntity(context: viewContext)
        user.uuid = UUID()
        user.name = "Invoker"
        user.alphabets = []
        user.avatar = avatar
        user.reminder = reminder
        let lesson1 = LessonEntity(context: viewContext)
        lesson1.uuid = UUID()
        lesson1.alphabets = []
        lesson1.name = "1"
        lesson1.user = user
        let lesson2 = LessonEntity(context: viewContext)
        lesson2.uuid = UUID()
        lesson2.name = "2"
        lesson2.alphabets = []
        lesson2.user = user
        let lesson3 = LessonEntity(context: viewContext)
        lesson3.uuid = UUID()
        lesson3.name = "3"
        lesson3.alphabets = []
        lesson3.user = user
        let lesson4 = LessonEntity(context: viewContext)
        lesson4.uuid = UUID()
        lesson4.name = "4"
        lesson4.alphabets = []
        lesson4.user = user
        let lesson5 = LessonEntity(context: viewContext)
        lesson5.uuid = UUID()
        lesson5.name = "5"
        lesson5.alphabets = []
        lesson5.user = user

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LexPlay")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true

//        Seeder
        let seeder = Seeder()
        seeder.seedAlphabet(context: container.viewContext)
    }
}
