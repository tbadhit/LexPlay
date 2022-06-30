//
//  UserAlphabetRepository.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 30/06/22.
//

import Foundation

protocol UserAlphabetRepositoryProtocol {
  func getAllUserAlphabet() -> [UserAlphabetEntity]
  func addPictureAlphabet(userAlphabet: UserAlphabetEntity, imageData: Data, hasDifficulity: Bool)
}


class UserAlphabetRepository {
  private let persistanceController = PersistenceController.shared
  private let context = PersistenceController.shared.container.viewContext
  
  private func save() {
    do {
      try context.save()
    } catch {
      print(error)
    }
  }
}

extension UserAlphabetRepository: UserAlphabetRepositoryProtocol {
  func getAllUserAlphabet() -> [UserAlphabetEntity] {
    return try! context.fetch(UserAlphabetEntity.fetchRequest())
  }
  
  func addPictureAlphabet(userAlphabet: UserAlphabetEntity, imageData: Data, hasDifficulity: Bool) {
    
  }
  
  
}
