//
//  QuizView.swift
//  LexPlay
//
//  Created by erlina ng on 20/08/22.
//

import SwiftUI

struct QuizView: View {
    @State var progressbarValue : Float = 0.0
    @State var quizzes: [BaseQuiz]
    @State var indexSoal = 0
    let quizService = QuizService()
    let audioService = AudioService.shared
    let speechRecognizerService = SpeechRecognizerService.shared
    let user: UserEntity
    let lesson: LessonEntity? = nil
    
    var body: some View {
        
        VStack {
            //MARK : Header Quiz
            HStack {
                Spacer()
                Spacer()
                HStack {
                    Text("QUIZ")
                        .frame(width: UIScreen.screenWidth / 3, alignment: .leading)
                    Image("quiz-header")
                        .resizable()
                        .frame(width: 140, height: 150, alignment: .trailing)
                        .scaledToFit()
                        .offset(y: 12)
                        .offset(x: 58)
                }
                .font(.custom(FontStyle.lexendMedium, size: 24))
                .frame(maxWidth: .infinity, maxHeight: 52)
                .cardPadding()
                .card()
                Spacer()
                Spacer()
            }
            .padding(.bottom)
            
            //MARK : Progress Bar
            ProgressBar(value: $progressbarValue)
                .frame(minHeight: 23, maxHeight: 30)
            
            //MARK : Iterate through Quizzes and shows each quiz
            if indexSoal < quizzes.count {
                switch quizzes[indexSoal] {
                case var alphabetByVoice as AlphabetByVoiceQuiz:
                    AlphabetByVoiceQuizView(quiz: Binding<AlphabetByVoiceQuiz>(get: {
                        alphabetByVoice
                    }, set: {
                        alphabetByVoice = $0
                    }), indexSoal: $indexSoal)

    //                case let imageByAlphabet as ImageByAlphabetQuiz:
    //                    AlphabetImageQuizView(quiz: imageByAlphabet)

                case var voiceByAlphabetQuiz as VoiceByAlphabetQuiz :
                    VoiceByAlphabetQuizView(quiz: Binding<VoiceByAlphabetQuiz>(get: {
                        voiceByAlphabetQuiz
                    }, set: {
                        voiceByAlphabetQuiz = $0
                    }), indexSoal: $indexSoal)

    //                case let alphabetBySpeakingQuiz as AlphabetBySpeakingQuiz :
    //                    AlphabetBySpeakingQuizView()

                default:
                    EmptyView()
                }
            } else {
                QuizEndView()
            }
            Spacer()
            Spacer()
        }
        .scrollOnOverflow()
        .backgroundImage(Asset.background)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: indexSoal) { newValue in
            if indexSoal != 0 {
                progressbarValue = (Float(indexSoal) / Float(quizzes.count))
            }
//            print(progressbarValue)
        }
    }
    
    init(user: UserEntity, lesson: LessonEntity? = nil) {
        self.user = user
        if let lesson = lesson {
            _quizzes = State(initialValue: quizService.getQuizzes(lesson: lesson))
        } else {
            _quizzes = State(initialValue: quizService.getQuizzes(user: user, count: 5))
        }
    }
}

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        HStack {
            Spacer()
            Spacer()
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .foregroundColor(Color.white)
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color("blue"))
                }.cornerRadius(45.0)
            }
            Spacer()
            Spacer()
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!)
            .previewInterfaceOrientation(.portrait)
    }
}
