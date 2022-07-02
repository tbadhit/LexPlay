//
//  CreateUserView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 01/07/22.
//

import SwiftUI

struct CreateUserView: View {
  
  @State var test = ""
  @State var isGoToSpecificLetterView = false
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.white, Color("background")]), startPoint: .top, endPoint: .bottom)
      VStack {
        
        Text("Pilih avatarmu!")
          .font(.custom(FontStyle.lexendMedium, size: 22))
        
        CardAvatar(imageName: "lex", imageWidth: 99, imageHeight: 151, avatarName: "Lex").padding(.bottom, 11)
        
        CardAvatar(imageName: "play", imageWidth: 104, imageHeight: 115, avatarName: "Play")
          .padding(.bottom, 24)
          
        
        TextField(text: $test) {
          Text("Username")
            .font(.custom(FontStyle.lexendMedium, size: 21))
        }
        .frame(maxWidth: .infinity, maxHeight: 75)
        .background(.white)
        .cornerRadius(38)
        .multilineTextAlignment(.center)
        .padding(.bottom, 11)
        
        Button {
          isGoToSpecificLetterView.toggle()
        } label: {
          Text("Create Profile")
            .frame(maxWidth: .infinity, maxHeight: 75)
            .foregroundColor(.white)
            .font(.custom(FontStyle.lexendMedium, size: 21))
          
        }
        .background(Color.red)
        .cornerRadius(38)
        
      }
      .padding([.horizontal], 20)
    }
    .navigationBarHidden(true)
    .ignoresSafeArea()
    
    
    // Navigation
    NavigationLink(isActive: $isGoToSpecificLetterView, destination: {
      SpecificLettersView()
    }, label: {
      EmptyView()
    })
    
  }
}

struct CardAvatar: View {
  
  let imageName: String
  let imageWidth: CGFloat
  let imageHeight: CGFloat
  let avatarName: String
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25, style: .continuous)
        .stroke(.red, lineWidth: 8)
      RoundedRectangle(cornerRadius: 25, style: .continuous)
        .fill(.white)
       
        
      
      HStack {
        Image(imageName)
          .resizable()
          .frame(width: imageWidth, height: imageHeight)
          .padding(.trailing, 25)
          .offset(y: 7.5)
        
        VStack(alignment: .leading) {
          Text("I'm")
            .font(.custom(FontStyle.lexendMedium, size: 21))
          Text(avatarName)
            .font(.custom(FontStyle.lexendSemiBold, size: 48))
        }
      }
      
      
      
    }
    .frame(maxWidth: .infinity, maxHeight: 166)
    
    
  }
}

struct CreateUserView_Previews: PreviewProvider {
  static var previews: some View {
    CreateUserView()
  }
}
