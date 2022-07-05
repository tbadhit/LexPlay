//
//  UserModel.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 05/07/22.
//

import Foundation

struct UserModel {
  var avatar: AvatarEntity?
  var name: String = ""
  var alphabets: [Alphabet] = []
  var letterCase: LetterCase = .upper
}
