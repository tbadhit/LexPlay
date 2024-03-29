//
//  CardAvatar.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 04/07/22.
//

import SwiftUI

struct CardAvatar: View {
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let avatar: AvatarEntity

    var body: some View {
        ZStack {
//      RoundedRectangle(cornerRadius: 25, style: .continuous)
//        .stroke(.red, lineWidth: 8)
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)

            HStack {
                Image(avatar.path ?? "")
                    .resizable()
//                    .frame(width: imageWidth, height: imageHeight)
                    .scaledToFit()
                    .padding(.trailing, 25)
                    .offset(y: 7.5)

                VStack(alignment: .leading) {
                    Text("Aku")
                        .font(.custom(FontStyle.lexendMedium, size: 21))
                    Text(avatar.name ?? "")
                        .font(.custom(FontStyle.lexendSemiBold, size: 48))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 166)
        .card()
    }
}

// struct CardAvatar_Previews: PreviewProvider {
//  static var previews: some View {
//    CardAvatar(imageName: "lex", imageWidth: 99, avatar: <#AvatarEntity#>, imageHeight: 151, avatarName: "Lex")
//      .background(.black)
//  }
// }
