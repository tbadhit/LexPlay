//
//  VoiceByAlphabetQuizView.swift
//  LexPlay
//
//  Created by erlina ng on 22/08/22.
//

import SwiftUI

struct VoiceByAlphabetQuizView: View {
    @State var idx = 0
    @State var quiz : VoiceByAlphabetQuiz
    private let audioController: AudioService = AudioService.shared
    @State var answer : String = ""
    @State var isCorrect : Bool = false
    @State var isPresented : Bool = false
    
    
    var body: some View {
        VStack (spacing: 30) {
            HStack {
                Button {
                    audioController.speak(quiz.question.rawValue)
                } label: {
                    Image(systemName: "speaker.circle.fill")
                        .foregroundColor(Color.brandBlue)
                        .font(.custom(FontStyle.lexendBlack, size: 114))
                }
            }
            .padding(.top)
            
            HStack {
                Spacer()
                Spacer()
                LetterAnswerOptionCard(answerOption: quiz.answerOptions![0], id: 1, idx: idx)
                    .onTapGesture {
                        idx = 1
                        isPresented = idx == 1
                        answer = quiz.answerOptions![0].rawValue
                        if answer == quiz.question.rawValue {
                            isCorrect = true
                        } else {
                            isCorrect = false
                        }
                    }
                    .alert(isPresented: ($isPresented)) {
                        return Alert(title: getAlertTitle(isCorrect: isCorrect),
                                     message: getAlertMessage(isCorrect: isCorrect),
                                     dismissButton: .default(Text(isCorrect ? "Batalkan" : "Oke"), action: {}))
                    }
                    
                Spacer()
                LetterAnswerOptionCard(answerOption: quiz.answerOptions![1], id: 2, idx: idx)
                    .onTapGesture {
                        idx = 2
                        isPresented = idx == 2
                        answer = quiz.answerOptions![1].rawValue
                        if answer == quiz.question.rawValue {
                            isCorrect = true
                        } else {
                            isCorrect = false
                        }
                    }
                    .alert(isPresented: ($isPresented)) {
                        return Alert(title: getAlertTitle(isCorrect: isCorrect),
                                     message: getAlertMessage(isCorrect: isCorrect),
                                     dismissButton: .default(Text(isCorrect ? "Batalkan" : "Oke"), action: {}))
                    }
                Spacer()
                Spacer()
            }
            
            HStack {
                Spacer()
                Spacer()
                LetterAnswerOptionCard(answerOption: quiz.answerOptions![2], id: 3, idx: idx)
                    .onTapGesture {
                        idx = 3
                        isPresented = idx == 3
                        answer = quiz.answerOptions![2].rawValue
                        if answer == quiz.question.rawValue {
                            isCorrect = true
                        } else {
                            isCorrect = false
                        }
                    }
                    .alert(isPresented: ($isPresented)) {
                        return Alert(title: getAlertTitle(isCorrect: isCorrect),
                                     message: getAlertMessage(isCorrect: isCorrect),
                                     dismissButton: .default(Text(isCorrect ? "Batalkan" : "Oke"), action: {}))
                    }
                Spacer()
                LetterAnswerOptionCard(answerOption: quiz.answerOptions![3], id: 4, idx: idx)
                    .onTapGesture {
                        idx = 4
                        isPresented = idx == 4
                        answer = quiz.answerOptions![3].rawValue
                        if answer == quiz.question.rawValue {
                            isCorrect = true
                        } else {
                            isCorrect = false
                        }
                    }
                    .alert(isPresented: ($isPresented)) {
                        return Alert(title: getAlertTitle(isCorrect: isCorrect),
                                     message: getAlertMessage(isCorrect: isCorrect),
                                     dismissButton: .default(Text(isCorrect ? "Batalkan" : "Oke"), action: {}))
                    }
                Spacer()
                Spacer()
            }
        }
    }
    
    func getAlertTitle(isCorrect : Bool) -> Text {
        return isCorrect ? Text("Benar!") : Text("Coba Lagi")
    }

    func getAlertMessage(isCorrect: Bool) -> Text {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        if isCorrect {
            feedbackGenerator.notificationOccurred(.success)
            return Text("🥳")
        }
        feedbackGenerator.notificationOccurred(.error)
        return Text("🤔")
    }
}

struct LetterAnswerOptionCard : View {
    let answerOption : Alphabet
    let id : Int
    let idx : Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 38, style: .continuous)
                .fill(id == idx ? Color("blue") : Color.white)
                .frame(maxWidth : 180,maxHeight: 180, alignment: .center)
            
            VStack {
                Text("\(answerOption.rawValue)")
                    .foregroundColor(id == idx ?  Color.white : Color("blue"))
                    .font(.custom(FontStyle.lexendMedium, size: 99))
                    .fontWeight(.semibold)
            }
        }
    }
}

//struct VoiceByAlphabetQuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        VoiceByAlphabetQuizView(question: "A", answer: "A")
//    }
//}
