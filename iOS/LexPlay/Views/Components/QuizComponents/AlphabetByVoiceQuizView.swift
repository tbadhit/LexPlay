//
//  AlphabetByVoiceQuizView.swift
//  LexPlay
//
//  Created by erlina ng on 22/08/22.
//

import SwiftUI

struct AlphabetByVoiceQuizView: View {
    @State var idx = 0
    @Binding var quiz : AlphabetByVoiceQuiz
    private let audioController: AudioService = AudioService.shared
    @State var answer : String = ""
    @State var isPresented : Bool = false
    @State private var disabled = true
    @Binding var indexSoal : Int
    
    var body: some View {
        VStack {
            Text("\(quiz.question.rawValue)")
                .foregroundColor(Color.brandBlack)
                .font(.custom(FontStyle.lexendMedium, size: 142))
                .fontWeight(.semibold)
                .frame(maxHeight: 162)
                .padding(.bottom, 30)
            
            HStack {
                Spacer()
                Spacer()
                VoiceAnswerOptionCard(answerOption: "bluey", id: 1, idx: idx)
                    .onTapGesture {
                        audioController.speak(quiz.answerOptions![0].rawValue)
                        idx = 1
                        answer = quiz.answerOptions![0].rawValue
                        quiz.submittedAnswer = quiz.answerOptions![0]
                        disabled = false
                    }
                Spacer()
                VoiceAnswerOptionCard(answerOption: "orangey", id: 2, idx: idx)
                    .onTapGesture {
                        audioController.speak(quiz.answerOptions![1].rawValue)
                        idx = 2
                        answer = quiz.answerOptions![1].rawValue
                        quiz.submittedAnswer = quiz.answerOptions![1]
                        disabled = false
                    }
                Spacer()
                Spacer()
            }
            HStack {
                Spacer()
                Spacer()
                VoiceAnswerOptionCard(answerOption: "limey", id: 3, idx: idx)
                    .onTapGesture {
                        audioController.speak(quiz.answerOptions![2].rawValue)
                        idx = 3
                        answer = quiz.answerOptions![2].rawValue
                        quiz.submittedAnswer = quiz.answerOptions![2]
                        disabled = false
                    }
                    
                Spacer()
                VoiceAnswerOptionCard(answerOption: "cyany", id: 4, idx: idx)
                    .onTapGesture {
                        audioController.speak(quiz.answerOptions![3].rawValue)
                        idx = 4
                        answer = quiz.answerOptions![3].rawValue
                        quiz.submittedAnswer = quiz.answerOptions![3]
                        disabled = false
                    }
                Spacer()
                Spacer()
            }
            .padding(.bottom, 20)
            
            Button {
//                print("Button Pressed")
                isPresented = true
            } label: {
                ZStack{
                    HStack {
                        Spacer()
                        Spacer()
                        RoundedRectangle(cornerRadius: 38, style: .continuous)
                            .fill(idx == 0 ? Color.white : Color("blue"))
                        .frame(minWidth: 240 , maxWidth : .infinity, minHeight: 55, maxHeight: 70, alignment: .center)
                        Spacer()
                        Spacer()
                    }
                    VStack {
                        Text("Selesai")
                            .foregroundColor(idx == 0 ? Color("blue") : Color.white)
                            .font(.custom(FontStyle.lexendMedium, size: 24))
                            .fontWeight(.semibold)
                    }
                }
            }
            .disabled(disabled)
            .alert(isPresented: ($isPresented)) {
                return Alert(title: getAlertTitle(isCorrect: quiz.checkAnswer()),
                             message: getAlertMessage(isCorrect: quiz.checkAnswer()),
                             dismissButton: .default(Text("Oke"), action: {
                    if quiz.checkAnswer() {
                        indexSoal+=1
                    }
                    //print(indexSoal)
                }))
            }
        }
        .onAppear {
            print(quiz.question)
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

struct VoiceAnswerOptionCard : View {
    let answerOption : String
    let id : Int
    let idx : Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 38, style: .continuous)
                .fill(Color.white)
                .frame(minWidth: 100, maxWidth : 180, minHeight: 120,maxHeight: 160, alignment: .center)
                .overlay(id == idx ?
                    RoundedRectangle(cornerRadius: 38)
                    .stroke(Color.brandBlue, lineWidth: 5).padding(.bottom, 2) :
                    RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.brandBlue, lineWidth: 0).padding(.bottom, 24))
            
            VStack {
                Image("\(answerOption)")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth:100, maxHeight: 100)
            }
        }
    }
}

//struct AlphabetByVoiceQuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlphabetByVoiceQuizView()
//    }
//}
