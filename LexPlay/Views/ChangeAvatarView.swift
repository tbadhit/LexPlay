//
//  ChangeAvatarView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 04/07/22.
//

import SwiftUI

struct ChangeAvatarView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \AvatarEntity.uuid, ascending: true)],
                  animation: .default) private var avatars: FetchedResults<AvatarEntity>
      
    var body: some View {
      ZStack {
        LinearGradient(gradient: Gradient(colors: [.white, Color("background-color")]), startPoint: .top, endPoint: .bottom)
        VStack {
          
          Text("Pilih Avatar")
            .font(.custom(FontStyle.lexendSemiBold, size: 24))
          
            CardAvatar(imageWidth: 99, imageHeight: 151, avatar : avatars[0]).padding(.bottom, 30)
          
            CardAvatar(imageWidth: 104, imageHeight: 115, avatar : avatars[1])
            .padding(.bottom, 70)
          
          Button {
            
          } label: {
            Text("Selesai")
              .frame(maxWidth: .infinity, maxHeight: 75)
              .foregroundColor(.white)
              .font(.custom(FontStyle.lexendMedium, size: 21))
          }
          .background(.red)
          .cornerRadius(38)
        }
        .padding([.horizontal], 20)
        
      }
      .ignoresSafeArea()
    }
}

struct ChangeAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeAvatarView()
    }
}
