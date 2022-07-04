//
//  OnboardingView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 01/07/22.
//

import SwiftUI

struct OnboardingView: View {
  
  @State var isNextOnboard = false
  
  var body: some View {
    NavigationView {
      ZStack {
        Image("onboard-bg-1")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .edgesIgnoringSafeArea(.top)
        
        VStack {
          Spacer()
          Text("Hello I'm Lex")
            .foregroundColor(Color.black)
            .font(.custom(FontStyle.lexendMedium, size: 21))
            .offset(y: -60)
          Spacer()
          Button {
            withAnimation(.easeIn(duration: 1)) {
              UserDefaults.standard.hasOnboarded = true
              isNextOnboard.toggle()
            }
          } label: {
            Text("Next")
              .frame(width: UIScreen.screenWidth / 1.5)
              .padding()
              .foregroundColor(Color.white)
              .background(Color.red)
              .cornerRadius(15)
              .font(.custom(FontStyle.lexendMedium, size: 21))
          }
          NavigationLink(destination: OnboardingView2(), isActive: $isNextOnboard, label: {
            EmptyView()
          })
          .padding(.bottom, 60)
        }
      }
      
      .navigationBarHidden(true)
    }
  }
}

struct OnboardingView2: View {
  var body: some View {
    ZStack {
      Image("onboard-bg-2")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea(.top)
      
      VStack {
        Spacer()
        Text("Hello I'm Play")
          .foregroundColor(Color.black)
          .font(.custom(FontStyle.lexendMedium, size: 21))
        Spacer()
        NavigationLink(destination: {
            CreateUserView(user: UserController())
        }, label: {
          Text("Next")
            .frame(width: UIScreen.screenWidth / 1.5)
            .padding()
            .foregroundColor(Color.white)
            .background(Color.red)
            .cornerRadius(15)
            .font(.custom(FontStyle.lexendMedium, size: 21))
        })
        .padding(.bottom, 60)
      }
    }
    .navigationBarHidden(true)
  }
}

//struct OnboardingView_Previews: PreviewProvider {
//  static var previews: some View {
//    OnboardingView2()
//  }
//}

extension UIScreen {
  static let screenWidth = UIScreen.main.bounds.size.width
  static let screenHeight = UIScreen.main.bounds.size.height
}
