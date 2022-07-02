//
//  LessonRepository.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 02/07/22.
//

import Foundation
import CoreData

protocol LessonRepositoryProtocol {
    func getLessons(user: UserEntity) -> [LessonEntity]
}

class LessonRepository {
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

extension LessonRepository: LessonRepositoryProtocol {
    func getLessons(user: UserEntity) -> [LessonEntity] {
        guard let uuid = user.uuid else { return [] }
        let request = LessonEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(LessonEntity.user.uuid), uuid as CVarArg)
        return try! context.fetch(request)
    }
}