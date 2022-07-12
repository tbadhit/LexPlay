//
//  CustomAlphabetView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 04/07/22.
//

import SwiftUI

struct CustomAlphabetView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var user: UserModel
    
    private let alphabetController: AlphabetService = AlphabetService()
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
    
    
    @State var selectionsAlphabet: [String] = []
    @State var isGoToSelecLetterCase = false
    
    @GestureState var buttonWidth = false
    
    func alphabets() -> [String] {
        var items: [String] = []
        for char in alphabetController.getAlphabets() {
            items.append("\(char.rawValue)")
        }
        
        return items
    }
    
    
    var body: some View {
        VStack {
            CardSays(imageName: "lex", information: "Pilih alphabet yang\ningin dipelajari")
                .padding(.bottom, 30)
            
            // Custom Huruf
            TabView {
                ForEach(0 ..< Int((Double(alphabets().count) / 4.0).rounded(.up)), id: \.self) { tabViewIndex in
                    VStack {
                        VStack {
                            LazyVGrid(columns: columns, spacing: 16) {
                                if tabViewIndex == 6 {
                                    ForEach(0 ..< 2, id: \.self) { i in
                                        let alphabet = alphabetController.generateCustomAlphabet(alphabets: alphabets(), index: i, tabviewIndex: tabViewIndex)
                                        CardAlphabet(alphabet: alphabetController.generateCustomAlphabet(alphabets: alphabets(), index: i, tabviewIndex: tabViewIndex), isCardSelected: selectionsAlphabet.contains(alphabet)) {
                                            if selectionsAlphabet.contains(alphabet) {
                                                selectionsAlphabet.removeAll(where: { $0 == alphabet })
                                            } else {
                                                selectionsAlphabet.append(alphabet)
                                            }
                                        }
                                    }
                                } else {
                                    ForEach(0 ..< 4, id: \.self) { i in
                                        let alphabet = alphabetController.generateCustomAlphabet(alphabets: alphabets(), index: i, tabviewIndex: tabViewIndex)
                                        CardAlphabet(alphabet: alphabetController.generateCustomAlphabet(alphabets: alphabets(), index: i, tabviewIndex: tabViewIndex), isCardSelected: selectionsAlphabet.contains(alphabet)) {
                                            if selectionsAlphabet.contains(alphabet) {
                                                selectionsAlphabet.removeAll(where: { $0 == alphabet })
                                            } else {
                                                selectionsAlphabet.append(alphabet)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.screenWidth + 16)
            .tabViewStyle(.page)
            
            Button {
                self.user.alphabets = selectionsAlphabet.map {
                    Alphabet(rawValue: ($0.first?.lowercased())!)!
                }
                self.isGoToSelecLetterCase.toggle()
            } label: {
                Text("Selesai")
                    .font(.lexendMedium(21))
                    .foregroundColor(.white)
                    .frame(maxWidth: buttonWidth ? UIScreen.screenWidth - 60 : .infinity , minHeight: buttonWidth ? 70 : 75)
                    .background(selectionsAlphabet.count < 1 ? LinearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing) :Color.buttonAndSelectedtColor)
            }
            .simultaneousGesture(LongPressGesture(minimumDuration: 10).updating($buttonWidth, body: { currentState, gestureState, transaction in
                transaction.animation = Animation.easeInOut(duration: 0.0)
                gestureState = currentState
            }))
            .cornerRadius(buttonWidth ? 100 : 38)
            .animation(.easeInOut, value: buttonWidth)
            .frame(maxHeight: 75)
            .disabled(selectionsAlphabet.count < 1)
            
            Spacer()
            
            
            
            
            NavigationLink(isActive: $isGoToSelecLetterCase) {
                LetterCaseView(user: user).environment(\.managedObjectContext, viewContext)
            } label: {
                EmptyView()
            }
        }
        .padding(.horizontal, 20)
        .navigationBarTitleDisplayMode(.inline)
        .background(Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
}

struct CustomAlphabetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlphabetView(user: UserModel())
            .font(.lexendRegular())
            .foregroundColor(Color("black"))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct CardAlphabet: View {
    let alphabet: String
    var isCardSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            if isCardSelected {
                Text(alphabet)
                    .font(.lexendSemiBold(72))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.screenWidth / 2.5, height: UIScreen.screenWidth / 2.5)
                    .background(Color.buttonAndSelectedtColor)
                    .cornerRadius(32)
                
            } else {
                Text(alphabet)
                    .font(.lexendSemiBold(72))
                    .frame(width: UIScreen.screenWidth / 2.5, height: UIScreen.screenWidth / 2.5)
                    .card()
            }
        }
    }
}
