//
//  Quiz.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 19/08/22.
//

import Foundation

class BaseQuiz {}

class Quiz<Question, Answer>: BaseQuiz {
    var question: Question
    var answer: Answer
    var answerOptions: [Answer]?
    var submittedAnswer: Answer?

    init(question: Question, answer: Answer, answerOptions: [Answer]?) {
        self.question = question
        self.answer = answer
        self.answerOptions = answerOptions
    }
}

class AlphabetQuiz: Quiz<Alphabet, Alphabet> {}

class AlphabetSpeakingQuiz: Quiz<Alphabet, [String]> {}

class AlphabetImageQuiz: Quiz<Data, Alphabet> {}

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
