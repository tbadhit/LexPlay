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
  
  func generateCustomAlphabet(alphabets: [String], index: Int, tabviewIndex: Int) -> String {
    var textAlphabet = ""
    switch tabviewIndex {
    case 0:
      textAlphabet = alphabets[index].uppercased() + alphabets[index].lowercased()
      break
    case 1:
      textAlphabet = alphabets[index + 4].uppercased() + alphabets[index + 4].lowercased()
      break
    case 2:
      textAlphabet = alphabets[index + 8].uppercased() + alphabets[index + 8].lowercased()
      break
    case 3:
      textAlphabet = alphabets[index + 12].uppercased() + alphabets[index + 12].lowercased()
      break
    case 4:
      textAlphabet = alphabets[index + 16].uppercased() + alphabets[index + 16].lowercased()
      break
    case 5:
      textAlphabet = alphabets[index + 20].uppercased() + alphabets[index + 20].lowercased()
      break
    case 6:
      textAlphabet = alphabets[index + 24].uppercased() + alphabets[index + 24].lowercased()
      break
    default:
      textAlphabet = ""
    }
    return textAlphabet
  }
}
