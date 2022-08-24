//
//  Quiz.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 19/08/22.
//

import Foundation

class BaseQuiz {}

class Quiz<Question, Answer: Equatable>: BaseQuiz {
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
        return answer == submittedAnswer
    }
}

class AlphabetQuiz: Quiz<AlphabetEntity, AlphabetEntity> {}

class AlphabetSpeakingQuiz: Quiz<AlphabetEntity, [String]> {
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

class AlphabetImageQuiz: Quiz<Data, AlphabetEntity> {}

// Specific Quizzes
class AlphabetBySpeakingQuiz: AlphabetSpeakingQuiz {}

class VoiceByAlphabetQuiz: AlphabetQuiz {}

class AlphabetByVoiceQuiz: AlphabetQuiz {}

class ImageByAlphabetQuiz: AlphabetImageQuiz {}
