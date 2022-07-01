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
  
  // user punya bbrp lesson -> lesson punya beberapa user alphabet -> user alphabet punya alphabet
  
  func addPictureAlphabet(userAlphabet: UserAlphabetEntity, imageData: Data, hasDifficulity: Bool) {
    userAlphabet.hasDifficulty = hasDifficulity
    userAlphabet.imageAssociation = imageData
    
    save()
  }
  
    func saveAlphabets(user : UserEntity, alphabets : [AlphabetEntity]) {
        //get all alphabets dari A - Z
        let allAlphabets = try! context.fetch(AlphabetEntity.fetchRequest())
        for savedAlphabet in allAlphabets {
            let newUserAlphabet = UserAlphabetEntity(context: context)
            newUserAlphabet.alphabet = savedAlphabet
            newUserAlphabet.user = user
            for alphabet in alphabets {
                if alphabet.uuid == savedAlphabet.uuid {
                    newUserAlphabet.hasDifficulty = true
                    break
                }
            }
        }
        save()
    }
}
