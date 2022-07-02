//
//  UserAlphabet.swift
//  LexPlay
//
//  Created by erlina ng on 01/07/22.
//

import Foundation

class UserAlphabet {
    
    private var userAlphabetRepository : UserAlphabetRepository
    private var user : UserEntity
    
    init(user: UserEntity = UserRepository().getActiveUser()!, userAlphabetRepository : UserAlphabetRepository = UserAlphabetRepository()) {
        self.user = user
        self.userAlphabetRepository = userAlphabetRepository
    }
    
    private func addUserAlphabet (user: UserEntity, alphabets : [Alphabet], letterCase : LetterCase) {
        var alphabetEntity : [AlphabetEntity] = []
        for alphabet in alphabets {
            alphabetEntity.append(userAlphabetRepository.getAlphabet(alphabet: alphabet, letterCase: letterCase))
        }
        userAlphabetRepository.saveAlphabets(user: user, alphabets: alphabetEntity)
    }
}
