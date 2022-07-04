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
    private let user: UserEntity

    init(userAlphabetRepository: UserAlphabetRepositoryProtocol = UserAlphabetRepository(viewContext: PersistenceController.shared.container.viewContext), user: UserEntity = UserRepository().getActiveUser()!) {
        self.userAlphabetRepository = userAlphabetRepository
        self.user = user
    }

    private func saveUppercaseUserAlphabets(alphabets: [Alphabet]) {
        var newAlphabets = [AlphabetEntity]()
        alphabets.forEach { alphabet in
            newAlphabets.append(userAlphabetRepository.getAlphabet(alphabet: alphabet, letterCase: .upper))
        }
        userAlphabetRepository.saveAlphabets(user: user, alphabets: newAlphabets)
    }

    private func saveLowercaseUserAlphabets(alphabets: [Alphabet]) {
        var newAlphabets = [AlphabetEntity]()
        alphabets.forEach { alphabet in
            newAlphabets.append(userAlphabetRepository.getAlphabet(alphabet: alphabet, letterCase: .lower))
        }
        userAlphabetRepository.saveAlphabets(user: user, alphabets: newAlphabets)
    }
}

extension UserAlphabetController {
    func getPredicate() -> FetchRequest<UserAlphabetEntity> {
        return FetchRequest<UserAlphabetEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \UserAlphabetEntity.alphabet?.char, ascending: true)], predicate: NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.user.uuid), user.uuid! as CVarArg))
    }
    
    func getPredicateByLesson(lesson: LessonEntity) -> FetchRequest<UserAlphabetEntity> {
        return FetchRequest<UserAlphabetEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \UserAlphabetEntity.alphabet?.char, ascending: true)], predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.user.uuid), user.uuid! as CVarArg),
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
