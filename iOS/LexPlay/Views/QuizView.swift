//
//  QuizView.swift
//  LexPlay
//
//  Created by erlina ng on 20/08/22.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        VStack {
            Image(systemName: "xmark")
                .font(Font.system(size: 30, weight: .bold))
                .padding(.bottom)
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
            HStack {
                Spacer()
                HStack {
                    Text("Quiz")
                        .frame(width: UIScreen.screenWidth / 3, alignment: .leading)
                    Image("quiz-header")
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .trailing)
                        .scaledToFit()
                        .offset(y: 12)
                        .offset(x: 58)
                }
                .font(.custom(FontStyle.lexendMedium, size: 24))
                .frame(maxWidth: .infinity, maxHeight: 52)
                .cardPadding()
                .card()
                Spacer()
            }
        }
        .scrollOnOverflow()

        .backgroundImage(Asset.background)
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
