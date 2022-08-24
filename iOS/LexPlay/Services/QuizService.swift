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
    
    func getQuizzes(user: UserEntity, count: Int? = nil) -> [BaseQuiz] {
        guard let userAlphabets = user.alphabets?.toArray(of: UserAlphabetEntity.self) else { return [] }
        return getQuizzes(userAlphabets: userAlphabets, count: count)
    }

    func getQuizzes(userAlphabets: [UserAlphabetEntity], count: Int? = nil) -> [BaseQuiz] {
//        var userAlphabets = userAlphabets.shuffled()
//        if let count = count, count < userAlphabets.count {
//            userAlphabets = Array(userAlphabets[...(count - 1)])
//        }
        var quizzes = [BaseQuiz]()

        let alphabets: [Alphabet] = userAlphabets.compactMap { userAlphabet in
            guard let alphabetEntity = userAlphabet.alphabet, let char = alphabetEntity.char, let alphabet = Alphabet(rawValue: char) else { return nil }
            return alphabet
        }

        for (i, alphabet) in alphabets.enumerated() {
            //quizzes.append(getAlphabetBySpeakingQuiz(alphabet: alphabet))
            quizzes.append(getVoiceByAlphabetQuiz(alphabet: alphabet, alphabets: alphabets))
            quizzes.append(getAlphabetByVoiceQuiz(alphabet: alphabet, alphabets: alphabets))
//            if let imageByAlphabetQuiz = getImageByAlphabetQuiz(userAlphabet: userAlphabets[i], alphabet: alphabet, alphabets: alphabets) {
//                quizzes.append(imageByAlphabetQuiz)
//            }
        }

        quizzes.shuffle()

        if let count = count {
            return Array(quizzes[...(count - 1)])
        }

        return quizzes
    }

    func getCorrectAnswersCount(quizzes: [BaseQuiz]) -> (correct: Int, totalQuestions: Int) {
        var score: (correct: Int, totalQuestions: Int) = (0, quizzes.count)
        quizzes.forEach { quiz in
            switch quiz {
            case let alphabetQuiz as AlphabetQuiz:
                score.correct += alphabetQuiz.checkAnswer().hashValue
                break
            case let alphabetSpeakingQuiz as AlphabetSpeakingQuiz:
                score.correct += alphabetSpeakingQuiz.checkAnswer().hashValue
                break
            case let alphabetImageQuiz as AlphabetImageQuiz:
                score.correct += alphabetImageQuiz.checkAnswer().hashValue
                break
            default:
                break
            }
        }

        return score
    }

    func getFinalScore(quizzes: [BaseQuiz]) -> Float {
        let correctAnswersCount = getCorrectAnswersCount(quizzes: quizzes)
        return Float(correctAnswersCount.correct) / Float(correctAnswersCount.totalQuestions)
    }

    func example() {
        let user = UserEntity()
        let userAlphabets = user.alphabets?.toArray(of: UserAlphabetEntity.self)
        guard let userAlphabets = userAlphabets else { return }
        let quizzes = getQuizzes(userAlphabets: userAlphabets, count: 10)

        quizzes.forEach { quiz in
            switch quiz {
            case let alphabetByVoice as AlphabetByVoiceQuiz:
                let question = alphabetByVoice.question
                let answerOptions = alphabetByVoice.answerOptions
                let answer = alphabetByVoice.answer

                audioService.speak(question.rawValue)
                let isCorrect = speechRecognizerService.isCorrect(alphabet: question, spoken: answer.rawValue)
                break
            case let imageByAlphabet as ImageByAlphabetQuiz:
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
    private func getAnswerOptions(alphabet: Alphabet, alphabets: [Alphabet]) -> [Alphabet] {
        let randomAlphabets = alphabets.shuffled()[...2]
        return (randomAlphabets + [alphabet]).shuffled()
    }

    private func getAlphabetBySpeakingQuiz(alphabet: Alphabet) -> AlphabetBySpeakingQuiz {
        return AlphabetBySpeakingQuiz(question: alphabet, answer: alphabet.spellings, answerOptions: nil)
    }

    private func getVoiceByAlphabetQuiz(alphabet: Alphabet, alphabets: [Alphabet]) -> VoiceByAlphabetQuiz {
        return VoiceByAlphabetQuiz(question: alphabet, answer: alphabet, answerOptions: getAnswerOptions(alphabet: alphabet, alphabets: alphabets))
    }

    private func getAlphabetByVoiceQuiz(alphabet: Alphabet, alphabets: [Alphabet]) -> AlphabetByVoiceQuiz {
        return AlphabetByVoiceQuiz(question: alphabet, answer: alphabet, answerOptions: getAnswerOptions(alphabet: alphabet, alphabets: alphabets))
    }

    private func getImageByAlphabetQuiz(userAlphabet: UserAlphabetEntity, alphabet: Alphabet, alphabets: [Alphabet]) -> ImageByAlphabetQuiz? {
        guard let image = userAlphabet.imageAssociation else { return nil }
        return ImageByAlphabetQuiz(question: image, answer: alphabet, answerOptions: getAnswerOptions(alphabet: alphabet, alphabets: alphabets))
    }
}
