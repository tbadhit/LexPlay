//
//  LessonRepository.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 30/06/22.
//

import Foundation

protocol LessonRepositoryProtocol {
    
}

class LessonRepository {
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
