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
        return lessonRepository.getLessons(user: user)
    }
}
