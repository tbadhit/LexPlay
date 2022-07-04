//
//  CustomAlphabetView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 04/07/22.
//

import SwiftUI

struct CustomAlphabetView: View {
  private let alphabetController: AlphabetController = AlphabetController()
  private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
  @State var isCardSelected = false
  @State var selectionsAlphabet: [String] = []
  
  func alphabets() -> [String] {
    var items: [String] = []
    for char in alphabetController.getAlphabets() {
      items.append("\(char.rawValue)")
    }
    
    return items
  }
  
  func generateAlphabet(alphabets: [String], index: Int, tabviewIndex: Int) -> String {
    var textAlphabet = ""
    switch tabviewIndex {
    case 0:
      textAlphabet = alphabets[index].uppercased() + alphabets[index].lowercased()
      break
    case 1:
      textAlphabet = alphabets[index + 4].uppercased() + alphabets[index + 4].lowercased()
      break
    case 2:
      textAlphabet = alphabets[index + 8].uppercased() + alphabets[index + 8].lowercased()
      break
    case 3:
      textAlphabet = alphabets[index + 12].uppercased() + alphabets[index + 12].lowercased()
      break
    case 4:
      textAlphabet = alphabets[index + 16].uppercased() + alphabets[index + 16].lowercased()
      break
    case 5:
      textAlphabet = alphabets[index + 20].uppercased() + alphabets[index + 20].lowercased()
      break
    case 6:
      textAlphabet = alphabets[index + 24].uppercased() + alphabets[index + 24].lowercased()
      break
    default:
      textAlphabet = ""
    }
    return textAlphabet
  }
  
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.white, Color("background-color")]), startPoint: .top, endPoint: .bottom)
      
      VStack {
        CardSays(imageName: "lex", widthImage: 108, heightImage: 182)
        
        // Custom Huruf
        TabView {
          ForEach(0 ..< 7, id: \.self) {tabViewIndex in
            VStack {
              VStack {
                LazyVGrid(columns: columns, spacing: 16) {
                  if tabViewIndex == 6 {
                    ForEach(0 ..< 2, id: \.self) { i in
                      let alphabet = generateAlphabet(alphabets: alphabets(), index: i, tabviewIndex: tabViewIndex)
                      CardAlphabet(alphabet: generateAlphabet(alphabets: alphabets(), index: i, tabviewIndex: tabViewIndex), isCardSelected: selectionsAlphabet.contains(alphabet)) {
                        if selectionsAlphabet.contains(alphabet) {
                          selectionsAlphabet.removeAll(where: { $0 == alphabet })
                        } else {
                          selectionsAlphabet.append(alphabet)
                        }
                      }
                      
                    }
                  } else {
                    ForEach(0 ..< 4, id: \.self) { i in
                      let alphabet = generateAlphabet(alphabets: alphabets(), index: i, tabviewIndex: tabViewIndex)
                      CardAlphabet(alphabet: generateAlphabet(alphabets: alphabets(), index: i, tabviewIndex: tabViewIndex), isCardSelected: selectionsAlphabet.contains(alphabet)) {
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
          
        } label: {
          Text("Selesai")
            .font(.custom(FontStyle.lexendMedium, size: 21))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 75)
        }
        .background(.red)
        .cornerRadius(38)
        
        
        
      }
      .padding(.horizontal, 20)
      
      
      
    }
    .ignoresSafeArea()
  }
}

struct CustomAlphabetView_Previews: PreviewProvider {
  static var previews: some View {
    CustomAlphabetView()
  }
}

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
        .font(.custom(FontStyle.lexendMedium, size: 21))
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
          .font(.custom(FontStyle.lexendSemiBold, size: 72))
          .foregroundColor(.white)
          .frame(width: UIScreen.screenWidth / 2.5, height: UIScreen.screenWidth / 2.5)
          .background(.red)
          .cornerRadius(32)
        
      } else {
        
        Text(alphabet)
          .font(.custom(FontStyle.lexendSemiBold, size: 72))
          .frame(width: UIScreen.screenWidth / 2.5, height: UIScreen.screenWidth / 2.5)
          .card()
      }
    }
    
  }
}
