//
//  AlphabetImageQuizView.swift
//  LexPlay
//
//  Created by erlina ng on 21/08/22.
//

import SwiftUI

struct AlphabetImageQuizView: View {
    let answerOptions = ["A","B","C","D"]
    @State var idx : Int = 0
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("example")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(45)
                Spacer()
            }
            .frame(maxWidth:.infinity, maxHeight: 400)
            .padding(.top)
            HStack {
                Spacer()
                Spacer()
                AnswerOptionCard(answerOption: answerOptions[0], id: 1, idx: idx)
                    .onTapGesture {
                        idx = 1
                    }
                Spacer()
                AnswerOptionCard(answerOption: answerOptions[1], id: 2, idx: idx)
                    .onTapGesture {
                        idx = 2
                    }
                Spacer()
                Spacer()
            }
            HStack {
                Spacer()
                Spacer()
                AnswerOptionCard(answerOption: answerOptions[2], id: 3, idx: idx)
                    .onTapGesture {
                        idx = 3
                    }
                Spacer()
                AnswerOptionCard(answerOption: answerOptions[3], id: 4, idx: idx)
                    .onTapGesture {
                        idx = 4
                    }
                Spacer()
                Spacer()
            }
        }
    }
}

struct AnswerOptionCard : View {
    let answerOption : String
    let id : Int
    let idx : Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 38, style: .continuous)
                .fill(id == idx ? Color("blue") : Color.white)
                .frame(minWidth: 40 , maxWidth : 160, minHeight: 55, maxHeight: 60, alignment: .center)
            
            VStack {
                Text("\(answerOption)")
                    .foregroundColor(id == idx ?  Color.white : Color("blue"))
                    .font(.custom(FontStyle.lexendMedium, size: 58))
                    .fontWeight(.semibold)
            }
        }
    }
}

struct AlphabetImageQuizView_Previews: PreviewProvider {
    static var previews: some View {
        AlphabetImageQuizView()
    }
}
