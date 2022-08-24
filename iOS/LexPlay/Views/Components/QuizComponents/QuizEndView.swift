//
//  QuizEndView.swift
//  LexPlay
//
//  Created by erlina ng on 24/08/22.
//

import SwiftUI

struct QuizEndView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Pelajaran\nSelesai!")
                .foregroundColor(Color.brandBlue)
                .font(.custom(FontStyle.lexendBlack, size: 24))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            HStack{
                Spacer()
                Spacer()
                Image("quiz-end")
                    .resizable()
                    .scaledToFit()
                Spacer()
                Spacer()
            }
            
            Button {
                print("Button Pressed")
            } label: {
                ZStack{
                    HStack {
                        Spacer()
                        Spacer()
                        RoundedRectangle(cornerRadius: 38, style: .continuous)
                            .fill(Color("blue"))
                        .frame(minWidth: 240 , maxWidth : .infinity, minHeight: 55, maxHeight: 70, alignment: .center)
                        Spacer()
                        Spacer()
                    }
                    VStack {
                        Text("Selesai")
                            .foregroundColor(Color.white)
                            .font(.custom(FontStyle.lexendMedium, size: 24))
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

struct QuizEndView_Previews: PreviewProvider {
    static var previews: some View {
        QuizEndView()
    }
}
