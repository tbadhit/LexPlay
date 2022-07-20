//
//  AlphabetService.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 01/07/22.
//

import Foundation

class AlphabetService {
    func getAlphabets() -> [Alphabet] {
        return Alphabet.allCases
    }

    func generateCustomAlphabet(alphabets: [String], index: Int, tabviewIndex: Int) -> String {
        var textAlphabet = ""
        if alphabets.count != 52 {
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
        } else {
            switch tabviewIndex {
            case 0:
                textAlphabet = alphabets[index]
                break
            case 1:
                textAlphabet = alphabets[index + 4]
                break
            case 2:
                textAlphabet = alphabets[index + 8]
                break
            case 3:
                textAlphabet = alphabets[index + 12]
                break
            case 4:
                textAlphabet = alphabets[index + 16]
                break
            case 5:
                textAlphabet = alphabets[index + 20]
                break
            case 6:
                textAlphabet = alphabets[index + 24]
                break
            case 7:
                textAlphabet = alphabets[index + 28]
                break
            case 8:
                textAlphabet = alphabets[index + 32]
                break
            case 9:
                textAlphabet = alphabets[index + 36]
                break
            case 10:
                textAlphabet = alphabets[index + 40]
                break
            case 11:
                textAlphabet = alphabets[index + 44]
                break
            case 12:
                textAlphabet = alphabets[index + 48]
                break
            default:
                textAlphabet = ""
            }
        }
        
        return textAlphabet
    }
}
