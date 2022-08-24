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
        return getQuizzes(userAlphabets: userAlphabets.filter({ $0.hasDifficulty }), count: count)
    }
    
    func getQuizzes(lesson: LessonEntity) -> [BaseQuiz] {
        guard let userAlphabets = lesson.alphabets?.toArray(of: UserAlphabetEntity.self) else { return [] }
        return getQuizzes(userAlphabets: userAlphabets)
    }

    func getQuizzes(userAlphabets: [UserAlphabetEntity], count: Int? = nil) -> [BaseQuiz] {
//        var userAlphabets = userAlphabets.shuffled()
//        if let count = count, count < userAlphabets.count {
//            userAlphabets = Array(userAlphabets[...(count - 1)])
//        }
        var quizzes = [BaseQuiz]()

        let alphabets: [AlphabetEntity] = userAlphabets.compactMap { userAlphabet in
            guard let alphabetEntity = userAlphabet.alphabet else { return nil }
            return alphabetEntity
        }

        for (_, alphabet) in alphabets.enumerated() {
            // quizzes.append(getAlphabetBySpeakingQuiz(alphabet: alphabet))
            quizzes.append(getVoiceByAlphabetQuiz(alphabet: alphabet, alphabets: alphabets))
            quizzes.append(getAlphabetByVoiceQuiz(alphabet: alphabet, alphabets: alphabets))
//            if let imageByAlphabetQuiz = getImageByAlphabetQuiz(userAlphabet: userAlphabets[i], alphabet: alphabet, alphabets: alphabets) {
//                quizzes.append(imageByAlphabetQuiz)
//            }
        }

        quizzes.shuffle()

        if let count = count, quizzes.count >= count {
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
}

extension QuizService {
    private func getAnswerOptions(alphabet: AlphabetEntity, alphabets: [AlphabetEntity]) -> [AlphabetEntity] {
        let shuffledAlphabets = alphabets.shuffled().filter { $0.toString() != alphabet.toString() }
        var randomDistinctAlphabets = [AlphabetEntity]()
        for alphabet in shuffledAlphabets {
            guard randomDistinctAlphabets.count < 3 else { break }
            if !randomDistinctAlphabets.compactMap({ $0.char }).contains(alphabet.char) {
                randomDistinctAlphabets.append(alphabet)
            }
        }
        return (randomDistinctAlphabets + [alphabet]).shuffled()
    }

    private func getAlphabetBySpeakingQuiz(alphabet: AlphabetEntity) -> AlphabetBySpeakingQuiz {
        return AlphabetBySpeakingQuiz(question: alphabet, answer: Alphabet(rawValue: alphabet.char!)!.spellings, answerOptions: nil)
    }

    private func getVoiceByAlphabetQuiz(alphabet: AlphabetEntity, alphabets: [AlphabetEntity]) -> VoiceByAlphabetQuiz {
        return VoiceByAlphabetQuiz(question: alphabet, answer: alphabet, answerOptions: getAnswerOptions(alphabet: alphabet, alphabets: alphabets))
    }

    private func getAlphabetByVoiceQuiz(alphabet: AlphabetEntity, alphabets: [AlphabetEntity]) -> AlphabetByVoiceQuiz {
        return AlphabetByVoiceQuiz(question: alphabet, answer: alphabet, answerOptions: getAnswerOptions(alphabet: alphabet, alphabets: alphabets))
    }

    private func getImageByAlphabetQuiz(userAlphabet: UserAlphabetEntity, alphabet: AlphabetEntity, alphabets: [AlphabetEntity]) -> ImageByAlphabetQuiz? {
        guard let image = userAlphabet.imageAssociation else { return nil }
        return ImageByAlphabetQuiz(question: image, answer: alphabet, answerOptions: getAnswerOptions(alphabet: alphabet, alphabets: alphabets))
    }
}
