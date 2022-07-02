//
//  AlphabetController.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 01/07/22.
//

import Foundation

class AlphabetController {
    func getAlphabets() -> [Alphabet] {
        return Alphabet.allCases
    }
}
