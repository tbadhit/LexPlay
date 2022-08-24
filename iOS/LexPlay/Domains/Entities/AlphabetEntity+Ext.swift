//
//  AlphabetEntity+Ext.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 25/08/22.
//

import Foundation

extension AlphabetEntity {
    func toString() -> String {
        let letterCase = LetterCase(rawValue: Int(letterCase))!
        return letterCase == .upper ? char!.uppercased() : char!.lowercased()
    }
    
    func toEnum() -> Alphabet {
        return Alphabet(rawValue: char!)!
    }
}
