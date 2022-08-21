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

    func submitAnswer(answer: Answer) {
        submittedAnswer = answer
    }

    func checkAnswer() -> Bool {
        return false
    }
}

class AlphabetQuiz: Quiz<Alphabet, Alphabet> {
    override func checkAnswer() -> Bool {
        return answer == submittedAnswer
    }
}

class AlphabetSpeakingQuiz: Quiz<Alphabet, [String]> {
    override func checkAnswer() -> Bool {
        return answer.contains(submittedAnswer?[0] ?? "")
    }

    /**
     Don't use this. Use the other one!
     */
    override func submitAnswer(answer: [String]) {
        super.submitAnswer(answer: answer)
    }

    func submitAnswer(answer: String) {
        submittedAnswer = [answer]
    }
}

class AlphabetImageQuiz: Quiz<Data, Alphabet> {
    override func checkAnswer() -> Bool {
        return answer == submittedAnswer
    }
}

class AlphabetBySpeakingQuiz: AlphabetSpeakingQuiz {}

class VoiceByAlphabetQuiz: AlphabetQuiz {}

class AlphabetByVoiceQuiz: AlphabetQuiz {}

class ImageByAlphabetQuiz: AlphabetImageQuiz {}
