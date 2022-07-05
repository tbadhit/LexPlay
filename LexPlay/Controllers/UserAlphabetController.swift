//
//  UserAlphabetController.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import Foundation
import SwiftUI

class UserAlphabetController {
    private let userAlphabetRepository: UserAlphabetRepositoryProtocol
    private let userRepository: UserRepository

    init(userAlphabetRepository: UserAlphabetRepositoryProtocol = UserAlphabetRepository(viewContext: PersistenceController.shared.container.viewContext), userRepository: UserRepository = UserRepository()) {
        self.userAlphabetRepository = userAlphabetRepository
      self.userRepository = userRepository
    }
  
  private func getUser() -> UserEntity {
    return userRepository.getActiveUser()!
  }

    private func saveUppercaseUserAlphabets(alphabets: [Alphabet]) {
        var newAlphabets = [AlphabetEntity]()
        alphabets.forEach { alphabet in
          if let alphabet = userAlphabetRepository.getAlphabet(alphabet: alphabet, letterCase: .upper) {
            newAlphabets.append(alphabet)
          }
        }
      
      userAlphabetRepository.saveAlphabets(user: getUser(), alphabets: newAlphabets)
    }

    private func saveLowercaseUserAlphabets(alphabets: [Alphabet]) {
        var newAlphabets = [AlphabetEntity]()
        alphabets.forEach { alphabet in
          print("Data alpabet : \(alphabet)")
          if let alphabet = userAlphabetRepository.getAlphabet(alphabet: alphabet, letterCase: .lower) {
            newAlphabets.append(alphabet)
          }
        }
        userAlphabetRepository.saveAlphabets(user: getUser(), alphabets: newAlphabets)
    }
}

extension UserAlphabetController {
    func getPredicate() -> FetchRequest<UserAlphabetEntity> {
        return FetchRequest<UserAlphabetEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \UserAlphabetEntity.alphabet?.char, ascending: true)], predicate: NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.user.uuid), getUser().uuid! as CVarArg))
    }
    
    func getPredicateByLesson(lesson: LessonEntity) -> FetchRequest<UserAlphabetEntity> {
        return FetchRequest<UserAlphabetEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \UserAlphabetEntity.alphabet?.char, ascending: true)], predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.user.uuid), getUser().uuid! as CVarArg),
            NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.lesson.uuid), lesson.uuid! as CVarArg)
        ]))
    }

    func getChar(alphabet: UserAlphabetEntity) -> String? {
        let char = (alphabet.alphabet?.char ?? "")
        guard let letterCaseInt = alphabet.alphabet?.letterCase else { return nil }
        let letterCase = LetterCase(rawValue: Int(letterCaseInt))
        switch letterCase {
        case .lower:
            return char.lowercased()
        default:
            return char.uppercased()
        }
    }

    func saveAlphabetsToUser(alphabets: [Alphabet], letterCase: LetterCase) {
        switch letterCase {
        case .upper:
            saveUppercaseUserAlphabets(alphabets: alphabets)
        case .lower:
            saveLowercaseUserAlphabets(alphabets: alphabets)
        case .both:
            saveLowercaseUserAlphabets(alphabets: alphabets)
            saveUppercaseUserAlphabets(alphabets: alphabets)
        }
    }

    func getAlphabets() -> [UserAlphabetEntity] {
        return userAlphabetRepository.getAllUserAlphabet().sorted { alphabet1, alphabet2 in
            if let char1 = alphabet1.alphabet?.char, let char2 = alphabet2.alphabet?.char {
                return char1 < char2
            }
            return true
        }
    }
}
