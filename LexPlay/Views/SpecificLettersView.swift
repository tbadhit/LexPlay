//
//  SpecificLettersView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 02/07/22.
//

import SwiftUI

struct SpecificLettersView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var user: UserModel
    @State var isGoToSelectLetterCase = false
    @State var isGoToCustomAlphabet = false
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                // Card
                GreetingCard(user: self.user)
                    .padding(.bottom, 20)
                
                // Card Question
                CardQuestion()
                    .padding(.bottom, 20)
                
                // Button
                HStack {
                    Button {
                        self.isGoToCustomAlphabet.toggle()
                        self.user.isLearnCustomLesson = true
                    } label: {
                        Text("Ya")
                            .frame(maxWidth: .infinity, maxHeight: 75)
                            .font(.custom(FontStyle.lexendMedium, size: 21))
                            .foregroundColor(.white)
                    }
                    .background(Color.buttonAndSelectedtColor)
                    .cornerRadius(38)
                    
                    Button {
                        isGoToSelectLetterCase.toggle()
                        self.user.alphabets = AlphabetService().getAlphabets()
                        self.user.isLearnCustomLesson = false
                    } label: {
                        Text("Tidak")
                            .frame(maxWidth: .infinity, maxHeight: 75)
                            .font(.custom(FontStyle.lexendMedium, size: 21))
                            .foregroundColor(.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 38)
                                    .stroke(.red, lineWidth: 7)
                            )
                    }
                    .background(.white)
                    .cornerRadius(38)
                }
                Spacer()
                
                NavigationLink(isActive: $isGoToCustomAlphabet) {
                    CustomAlphabetView(user: user).environment(\.managedObjectContext, viewContext)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $isGoToSelectLetterCase) {
                    LetterCaseView(user: user).environment(\.managedObjectContext, viewContext)
                } label: {
                    EmptyView()
                }
            }
            .padding(.horizontal, 20)
            
        }
        .background(Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
        .ignoresSafeArea()
    }
}

struct GreetingCard: View {
    let user: UserModel
    var body: some View {
        HStack {
            Image(user.avatar?.path ?? "play")
                .resizable()
                .scaledToFit()
                .frame(width: 108, height: 182)
                .padding(.trailing, 1)
                .offset(y: 17.7)
            
            VStack(alignment: .leading) {
                Text("Hellow,")
                    .font(.custom(FontStyle.lexendMedium, size: 21))
                Text("\(user.name)")
                    .font(.custom(FontStyle.lexendSemiBold, size: 36))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .card()
    }
}

struct CardQuestion: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 38, style: .continuous)
                .fill(.white)
            
            Text("Apakah kamu menginginkan\nalfabet tertentu untuk dipelajari?")
                .font(.custom(FontStyle.lexendMedium, size: 17))
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
}

struct SpecificLettersView_Previews: PreviewProvider {
    static var previews: some View {
        SpecificLettersView(user: UserModel())
    }
}
