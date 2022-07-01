//
//  AlphabetRepository.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 30/06/22.
//

import Foundation

protocol AlphabetRepositoryProtocol {
  func getAlphabet() -> [AlphabetEntity]
}

class AlphabetRepository {
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

extension AlphabetRepository: AlphabetRepositoryProtocol {
  func getAlphabet() -> [AlphabetEntity] {
    let request = AlphabetEntity.fetchRequest()
    return try! context.fetch(request)
  }
}
