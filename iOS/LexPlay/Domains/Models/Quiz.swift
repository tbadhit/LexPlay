//
//  Quiz.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 19/08/22.
//

import Foundation

protocol Quiz {
    associatedtype Question
    associatedtype Answer

    var question: Question { get }
    var answerOptions: [Answer]? { get }
    var answer: Answer { get }
}

struct AlphabetQuiz: Quiz {
    typealias Question = Alphabet
    typealias Answer = Alphabet

    var question: Alphabet
    var answerOptions: [Alphabet]?
    var answer: Alphabet
}

struct AlphabetImageQuiz: Quiz {
    typealias Question = Data
    typealias Answer = Alphabet

    var question: Data
    var answerOptions: [Alphabet]?
    var answer: Alphabet
}

// struct AlphabetBySpeaking: Quiz {
//    typealias Question = Alphabet
//    typealias Answer = Alphabet
//
//    var question: Alphabet
//    var answerOptions: [Alphabet]?
//    var answer: Alphabet
// }
//
// struct VoiceByAlphabet: Quiz {
//    typealias Question = Alphabet
//    typealias Answer = Alphabet
//
//    var question: Alphabet
//    var answerOptions: [Alphabet]?
//    var answer: Alphabet
// }
//
// struct AlphabetByVoice: Quiz {
//    typealias Question = Alphabet
//    typealias Answer = Alphabet
//
//    var question: Alphabet
//    var answerOptions: [Alphabet]?
//    var answer: Alphabet
// }
