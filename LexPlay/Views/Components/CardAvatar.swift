//
//  CardAvatar.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 04/07/22.
//

import SwiftUI

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

struct CardAvatar_Previews: PreviewProvider {
  static var previews: some View {
    CardAvatar(imageName: "lex", imageWidth: 99, imageHeight: 151, avatarName: "Lex")
  }
}
