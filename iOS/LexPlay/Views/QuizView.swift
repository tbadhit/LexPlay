//
//  QuizView.swift
//  LexPlay
//
//  Created by erlina ng on 20/08/22.
//

import SwiftUI

struct QuizView: View {
    @State var progressbarValue : Float = 0.2
    var quizzes = QuizService().getQuizzes(userAlphabets: (UserAlphabetRepository().getAllUserAlphabet()))
    var body: some View {
        VStack {
            //Header Quiz
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
            .onTapGesture {
                progressbarValue += 0.15 //Untuk Test Progress barnya bisa jalan gak
            }
            
            //Progress Bar
            ProgressBar(value: $progressbarValue)
                .frame(minHeight: 23, maxHeight: 30)
            
            //TODO : Add conditional statement to show different Quiz Question based on quiz type 
            Group {
                if quizzes != nil {
                    AlphabetBySpeakingQuizView()
                }
            }
            Spacer()
            Spacer()
        }
        .offset(y: -20)
        .backgroundImage(Asset.background)
        .onAppear {
            for i in quizzes {
                print(i)
            }
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
        QuizView()
            .previewInterfaceOrientation(.portrait)
    }
}
