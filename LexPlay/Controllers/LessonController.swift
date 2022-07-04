//
//  LessonController.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 02/07/22.
//

import Foundation

class LessonController {
    private let lessonRepository: LessonRepositoryProtocol
    let user: UserEntity
    
    init(lessonRepository: LessonRepositoryProtocol = LessonRepository(), user: UserEntity = UserRepository().getActiveUser()!) {
        self.lessonRepository = lessonRepository
        self.user = user
    }
    
    func getLessons() -> [LessonEntity] {
        return lessonRepository.getLessons(user: user).sorted { lesson1, lesson2 in
            guard let name1 = lesson1.name, let name2 = lesson2.name else { return true }
            guard let int1 = Int(name1), let int2 = Int(name2) else { return name1 < name2 }
            return int1 < int2
        }
    }
}
