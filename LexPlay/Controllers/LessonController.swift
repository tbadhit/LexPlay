//
//  LessonController.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 02/07/22.
//

import Foundation

class LessonController {
    private let lessonRepository: LessonRepositoryProtocol
    private let user: UserEntity
    
    init(lessonRepository: LessonRepositoryProtocol, user: UserEntity) {
        self.lessonRepository = lessonRepository
        self.user = user
    }
    
    func getLessons() -> [LessonEntity] {
        return lessonRepository.getLessons(user: user)
    }
}
