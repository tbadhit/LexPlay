//
//  CreateUserView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 01/07/22.
//

import SwiftUI

struct CreateUserView: View {
    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
          .fill(.white)
          .shadow(radius: 10)
        
        HStack {
          Image("lex")
            .resizable()
            .frame(width: 99, height: 151)
            .padding(.trailing, 25)
            
          
          VStack(alignment: .leading) {
            Text("I'm")
              .font(.custom(FontStyle.lexendMedium, size: 21))
            Text("Lex")
              .font(.custom(FontStyle.lexendSemiBold, size: 48))
          }
        }
        
        
      }
      .frame(width: UIScreen.screenWidth, height: 166)
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
