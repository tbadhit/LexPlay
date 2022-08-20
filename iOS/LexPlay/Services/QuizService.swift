//
//  QuizService.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 19/08/22.
//

import Foundation

class QuizService {
    static let shared = QuizService()
    let audioService = AudioService.shared
    let speechRecognizerService = SpeechRecognizerService.shared

    func getQuizzes(userAlphabets: [UserAlphabetEntity], count: Int? = nil) -> [Any] {
        var userAlphabets = userAlphabets.shuffled()
        if let count = count, count < userAlphabets.count {
            userAlphabets = Array(userAlphabets[...(count - 1)])
        }
        var quizzes = [Any]()

        let alphabets: [Alphabet] = userAlphabets.compactMap { userAlphabet in
            guard let alphabetEntity = userAlphabet.alphabet, let char = alphabetEntity.char, let alphabet = Alphabet(rawValue: char) else { return nil }
            return alphabet
        }

        alphabets.forEach { alphabet in
            quizzes.append(getAlphabetBySpeakingQuiz(alphabet: alphabet))
            quizzes.append(getVoiceByAlphabetQuiz(alphabets: alphabets, alphabet: alphabet))
            quizzes.append(getAlphabetByVoiceQuiz(alphabets: alphabets, alphabet: alphabet))
        }
        return quizzes
    }

    func example() {
        let user = UserEntity()
        let userAlphabets = user.alphabets?.toArray(of: UserAlphabetEntity.self)
        guard let userAlphabets = userAlphabets else { return }
        let quizzes = getQuizzes(userAlphabets: userAlphabets)

        quizzes.forEach { quiz in
            switch quiz {
            case let alphabetQuiz as AlphabetQuiz:
                let question = alphabetQuiz.question
                let answerOptions = alphabetQuiz.answerOptions
                let answer = alphabetQuiz.answer

                audioService.speak(question.rawValue)
                let isCorrect = speechRecognizerService.isCorrect(alphabet: question, spoken: answer.rawValue)
                break
            case let alphabetImageQuiz as AlphabetImageQuiz:
//                insert corresponding view
//                SomeView(quiz: alphabetImageQuiz)
                break
            default:
                break
            }
        }
    }
}

extension QuizService {
    private func getAlphabetBySpeakingQuiz(alphabet: Alphabet) -> AlphabetQuiz {
        return AlphabetQuiz(question: alphabet, answerOptions: nil, answer: alphabet)
    }

    private func getVoiceByAlphabetQuiz(alphabets: [Alphabet], alphabet: Alphabet) -> AlphabetQuiz {
        let randomAlphabets = Array(alphabets.shuffled()[...3])
        return AlphabetQuiz(question: alphabet, answerOptions: randomAlphabets, answer: alphabet)
    }

    private func getAlphabetByVoiceQuiz(alphabets: [Alphabet], alphabet: Alphabet) -> AlphabetQuiz {
        return getVoiceByAlphabetQuiz(alphabets: alphabets, alphabet: alphabet)
    }
}
