//
//  VoiceByAlphabetQuizView.swift
//  LexPlay
//
//  Created by erlina ng on 22/08/22.
//

import SwiftUI

struct VoiceByAlphabetQuizView: View {
    @ObservedObject var guideViewModel = GuideViewModel.shared
    @State var idx = 0
    @Binding var quiz : VoiceByAlphabetQuiz
    private let audioController: AudioService = AudioService.shared
    @State var answer : String = ""
    @State var isPresented : Bool = false
    @Binding var indexSoal : Int
    
    
    var body: some View {
        VStack (spacing: 30) {
            HStack {
                Button {
                    audioController.speak(alphabet: quiz.question)
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
                        answer = quiz.answerOptions![0].toString()
                        quiz.submittedAnswer = quiz.answerOptions![0]
                    }
                    
                Spacer()
                LetterAnswerOptionCard(answerOption: quiz.answerOptions![1], id: 2, idx: idx)
                    .onTapGesture {
                        idx = 2
                        isPresented = idx == 2
                        answer = quiz.answerOptions![1].toString()
                        quiz.submittedAnswer = quiz.answerOptions![1]
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
                        answer = quiz.answerOptions![2].toString()
                        quiz.submittedAnswer = quiz.answerOptions![2]
                    }
                Spacer()
                LetterAnswerOptionCard(answerOption: quiz.answerOptions![3], id: 4, idx: idx)
                    .onTapGesture {
                        idx = 4
                        isPresented = idx == 4
                        answer = quiz.answerOptions![3].toString()
                        quiz.submittedAnswer = quiz.answerOptions![3]
                    }
                Spacer()
                Spacer()
            }
            .alert(isPresented: ($isPresented)) {
                return Alert(title: getAlertTitle(isCorrect: quiz.checkAnswer()),
                             message: getAlertMessage(isCorrect: quiz.checkAnswer()),
                             dismissButton: .default(Text("Oke"), action: {
                    if quiz.checkAnswer() {
                        indexSoal+=1
                        idx = 0
                    }
                    //print(indexSoal)
                }))
            }
        }
        .onDidAppear {
            guideViewModel.guidingAudios = [.quiz__VoiceByAlphabet]
        }
        .onWillDisappear {
            guideViewModel.stopAndReset()
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
    let answerOption : AlphabetEntity
    let id : Int
    let idx : Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 38, style: .continuous)
                .fill(id == idx ? Color("blue") : Color.white)
                .frame(maxWidth : 180,maxHeight: 180, alignment: .center)
            
            VStack {
                Text("\(answerOption.toString())")
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
