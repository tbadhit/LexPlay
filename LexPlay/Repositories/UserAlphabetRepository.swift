//
//  UserAlphabetRepository.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 30/06/22.
//

import Foundation
import CoreData

protocol UserAlphabetRepositoryProtocol {
  func getAllUserAlphabet() -> [UserAlphabetEntity]
  func addPictureAlphabet(userAlphabet: UserAlphabetEntity, imageData: Data, hasDifficulity: Bool)
  func saveAlphabets(user : UserEntity, alphabets : [AlphabetEntity])
  func getAlphabet (alphabet : Alphabet, letterCase : LetterCase) -> AlphabetEntity?
}


class UserAlphabetRepository {
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
      let lesson1 = LessonEntity(context: context)
      lesson1.uuid = UUID()
      lesson1.name = "1"
      lesson1.user = user
      let lesson2 = LessonEntity(context: context)
      lesson2.uuid = UUID()
      lesson2.name = "2"
      lesson2.user = user
      let lesson3 = LessonEntity(context: context)
      lesson3.uuid = UUID()
      lesson3.name = "3"
      lesson3.user = user
      let lesson4 = LessonEntity(context: context)
      lesson4.uuid = UUID()
      lesson4.name = "4"
      lesson4.user = user
      let lesson5 = LessonEntity(context: context)
      lesson5.uuid = UUID()
      lesson5.name = "5"
      lesson5.user = user
      
      var count = 0
      
      var userAlphabets = [UserAlphabetEntity]()
      
        let allAlphabets = try! context.fetch(AlphabetEntity.fetchRequest())
        for savedAlphabet in allAlphabets {
            let newUserAlphabet = UserAlphabetEntity(context: context)
            newUserAlphabet.alphabet = savedAlphabet
            newUserAlphabet.user = user
          userAlphabets.append(newUserAlphabet)
            for alphabet in alphabets {
                if alphabet.uuid == savedAlphabet.uuid {
                    newUserAlphabet.hasDifficulty = true
                    break
                }
            }
        }
      
      let num = userAlphabets.count / 5
      userAlphabets.forEach { userAlphabet in
        if count < num {
          userAlphabet.lesson = lesson1
        } else if count < num * 2 {
          userAlphabet.lesson = lesson2
        } else if count < num * 3 {
          userAlphabet.lesson = lesson3
        } else if count < num * 4 {
          userAlphabet.lesson = lesson4
        } else {
          userAlphabet.lesson = lesson5
        }
        
        count += 1
      }
      
        save()
    }
    
    func getAlphabet (alphabet : Alphabet, letterCase : LetterCase) -> AlphabetEntity? {
        let request = AlphabetEntity.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
          NSPredicate(format: "%K == %@", #keyPath(AlphabetEntity.char.lowercased), alphabet.rawValue.lowercased()),
          NSPredicate(format: "%K == %@", #keyPath(AlphabetEntity.letterCase), NSNumber(value: letterCase.rawValue))
        ])
        return try! context.fetch(request).first
    }
}
