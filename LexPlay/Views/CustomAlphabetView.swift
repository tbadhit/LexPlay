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
  
  func alphabets() -> [String] {
    var items: [String] = []
    for char in alphabetController.getAlphabets() {
      items.append("\(char.rawValue)")
    }
    
    return items
  }
  
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.white, Color("background-color")]), startPoint: .top, endPoint: .bottom)
      
      VStack {
        CardSays(imageName: "lex", widthImage: 108, heightImage: 182)
        
        // Custom Huruf
        TabView {
          ForEach(0 ..< Int((Double(alphabets().count ) / 4.0).rounded(.up)), id: \.self) {tabViewIndex in
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
              .padding(.top, 30 )
              Spacer()
            }
          }
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.screenHeight / 2)
        .tabViewStyle(.page)
        .padding(.bottom, 30)
        
        Button {
          
          self.user.alphabets = selectionsAlphabet.map {
            Alphabet(rawValue: $0.lowercased())!
          }
          self.isGoToSelecLetterCase.toggle()
        } label: {
          Text("Selesai")
            .font(.custom(FontStyle.lexendMedium, size: 21))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 75)
        }
        .background(.red)
        .cornerRadius(38)
        
        
        NavigationLink(isActive: $isGoToSelecLetterCase) {
          LetterCaseView(user: user).environment(\.managedObjectContext, viewContext)
        } label: {
          EmptyView()
        }

        
        
      }
      .padding(.horizontal, 20)
      
      
      
    }
    .ignoresSafeArea()
  }
}

//struct CustomAlphabetView_Previews: PreviewProvider {
//  static var previews: some View {
//    CustomAlphabetView()
//      .font(.lexendRegular())
//      .foregroundColor(Color("black"))
//      .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//  }
//}

struct CardSays: View {
  
  let imageName: String
  let widthImage: CGFloat
  let heightImage: CGFloat
  
  var body: some View {
    HStack {
      Image(imageName)
        .resizable()
        .frame(width: widthImage, height: heightImage)
        .scaledToFit()
        .offset(y: 14)
        .padding(.trailing, 10)
      
      Text("Pilih alphabet yang\ningin dipelajari")
        .font(.lexendMedium(21))
    }
    .frame(maxWidth: .infinity, maxHeight: 100)
    .card()
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
          .background(.red)
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
