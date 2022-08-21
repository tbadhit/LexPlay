//
//  AlphabetBySpeakingQuizView.swift
//  LexPlay
//
//  Created by erlina ng on 20/08/22.
//

import SwiftUI

struct AlphabetBySpeakingQuizView: View {
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Spacer()
                Text("A")
                    .foregroundLinearGradient(colors: [Color("softBlue"), Color("softPurple")], startPoint: .top, endPoint: .bottom)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.screenHeight * 0.5)
                    .font(.custom(FontStyle.lexendMedium, size: 250))
                    .offset(y:-30)
                    .cardPadding()
                    .card()
                Spacer()
                Spacer()
            }
            .padding(.bottom)
            .padding(.top)
            
            
            HStack {
                Spacer()
                Spacer()
                Button {
                    print("Button Pressed")
                } label: {
                    Image(systemName: "mic.fill")
                        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 58)
                        .font(.custom(FontStyle.lexendBlack, size: 25))
                        .foregroundColor(.white)
                        .background(Color("blue"))
                        .cornerRadius(38)
                }
                Spacer()
                Spacer()
            }
            Spacer()
        }
    }
}

extension Text {
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self

            )
        }
    }
}

struct AlphabetBySpeakingQuizView_Previews: PreviewProvider {
    static var previews: some View {
        AlphabetBySpeakingQuizView()
    }
}
