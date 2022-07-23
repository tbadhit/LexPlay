//
//  UserAlphabetRepository.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 30/06/22.
//

import CoreData
import Foundation
import SwiftUI

protocol UserAlphabetRepositoryProtocol {
    func getAllUserAlphabet() -> [UserAlphabetEntity]
    func addPictureAlphabet(userAlphabet: UserAlphabetEntity, imageData: Data, hasDifficulity: Bool)
    func getAlphabet(alphabet: Alphabet, letterCase: LetterCase) -> AlphabetEntity?
}

class UserAlphabetRepository {
    private let context: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        context = viewContext
    }

    private func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    private func getUppercaseUserAlphabets(user: UserEntity, alphabets: [Alphabet]) -> [UserAlphabetEntity] {
        var newAlphabets = [AlphabetEntity]()
        alphabets.forEach { alphabet in
            if let alphabet = getAlphabet(alphabet: alphabet, letterCase: .upper) {
                newAlphabets.append(alphabet)
            }
        }

        return getUserAlphabets(user: user, alphabets: newAlphabets)
    }

    private func getLowercaseUserAlphabets(user: UserEntity, alphabets: [Alphabet]) -> [UserAlphabetEntity] {
        var newAlphabets = [AlphabetEntity]()
        alphabets.forEach { alphabet in
            if let alphabet = getAlphabet(alphabet: alphabet, letterCase: .lower) {
                newAlphabets.append(alphabet)
            }
        }

        return getUserAlphabets(user: user, alphabets: newAlphabets)
    }

    private func getUserAlphabets(user: UserEntity, alphabets: [AlphabetEntity]) -> [UserAlphabetEntity] {
        // get all alphabets dari A - Z
        var userAlphabets = [UserAlphabetEntity]()
        let alphabetRequest = AlphabetEntity.fetchRequest()
        alphabetRequest.sortDescriptors = [NSSortDescriptor(keyPath: \AlphabetEntity.timestamp, ascending: true)]
        let allAlphabets = try! context.fetch(alphabetRequest)
        for savedAlphabet in allAlphabets {
            let newUserAlphabet = UserAlphabetEntity(context: context)
            newUserAlphabet.uuid = UUID()
            newUserAlphabet.alphabet = savedAlphabet
            newUserAlphabet.user = user
            newUserAlphabet.timestamp = Date().timeIntervalSince1970
            for alphabet in alphabets {
                if alphabet.uuid == savedAlphabet.uuid {
                    newUserAlphabet.hasDifficulty = true
                    break
                }
            }
            userAlphabets.append(newUserAlphabet)
        }

        return userAlphabets.filter { $0.hasDifficulty }
    }
}

extension UserAlphabetRepository: UserAlphabetRepositoryProtocol {
    func saveAlphabetsToUser(user: UserEntity, alphabets: [Alphabet], letterCase: LetterCase) {
        var userAlphabets = [UserAlphabetEntity]()
        switch letterCase {
        case .upper:
            userAlphabets = getUppercaseUserAlphabets(user: user, alphabets: alphabets)
        case .lower:
            userAlphabets = getLowercaseUserAlphabets(user: user, alphabets: alphabets)
        case .both:
            userAlphabets = getUppercaseUserAlphabets(user: user, alphabets: alphabets) + getLowercaseUserAlphabets(user: user, alphabets: alphabets)
        }

        let lesson1 = LessonEntity(context: context)
        lesson1.uuid = UUID()
        lesson1.name = "1"
        lesson1.user = user
        lesson1.timestamp = Date().timeIntervalSince1970
        let lesson2 = LessonEntity(context: context)
        lesson2.uuid = UUID()
        lesson2.name = "2"
        lesson2.user = user
        lesson2.timestamp = Date().timeIntervalSince1970
        let lesson3 = LessonEntity(context: context)
        lesson3.uuid = UUID()
        lesson3.name = "3"
        lesson3.user = user
        lesson3.timestamp = Date().timeIntervalSince1970
        let lesson4 = LessonEntity(context: context)
        lesson4.uuid = UUID()
        lesson4.name = "4"
        lesson4.user = user
        lesson4.timestamp = Date().timeIntervalSince1970
        let lesson5 = LessonEntity(context: context)
        lesson5.uuid = UUID()
        lesson5.name = "5"
        lesson5.user = user
        lesson5.timestamp = Date().timeIntervalSince1970

        var count = 0
        let num = Int((Double(userAlphabets.count) / 5.0).rounded(.up))
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

    static func getByLessonPredicate(user: UserEntity, lesson: LessonEntity) -> FetchRequest<UserAlphabetEntity> {
        return FetchRequest<UserAlphabetEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \UserAlphabetEntity.alphabet?.char, ascending: true)], predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.user.uuid), user.uuid! as CVarArg),
            NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.lesson.uuid), lesson.uuid! as CVarArg),
        ]))
    }

    static func getCustomPredicate(user: UserEntity) -> FetchRequest<UserAlphabetEntity> {
        return FetchRequest<UserAlphabetEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \UserAlphabetEntity.alphabet?.char, ascending: true)], predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.user.uuid), user.uuid! as CVarArg),
            NSPredicate(format: "%K == %@", #keyPath(UserAlphabetEntity.hasDifficulty), NSNumber(value: true)),
        ]))
    }

    func getAllUserAlphabet() -> [UserAlphabetEntity] {
        return try! context.fetch(UserAlphabetEntity.fetchRequest())
    }

    // user punya bbrp lesson -> lesson punya beberapa user alphabet -> user alphabet punya alphabet

    func addPictureAlphabet(userAlphabet: UserAlphabetEntity, imageData: Data, hasDifficulity: Bool) {
        userAlphabet.hasDifficulty = hasDifficulity
        userAlphabet.imageAssociation = imageData

        save()
    }

    func getAlphabet(alphabet: Alphabet, letterCase: LetterCase) -> AlphabetEntity? {
        let request = AlphabetEntity.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "%K LIKE[c] %@", #keyPath(AlphabetEntity.char), alphabet.rawValue.lowercased()),
            NSPredicate(format: "%K == %@", #keyPath(AlphabetEntity.letterCase), NSNumber(value: letterCase.rawValue)),
        ])
        return try! context.fetch(request).first
    }
}
