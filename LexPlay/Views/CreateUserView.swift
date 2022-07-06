//
//  CreateUserView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 01/07/22.
//

import SwiftUI

struct CreateUserView: View {
  
  @Environment(\.managedObjectContext) private var viewContext
  
  @State var user = UserModel()
  
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \AvatarEntity.uuid, ascending: true)],
                animation: .default) private var avatars: FetchedResults<AvatarEntity>
  @State var avatar : AvatarEntity?
  @State var name = ""
  @State var isGoToSpecificLetterView = false
  
  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea(.all)
      //      LinearGradient(gradient: Gradient(colors: [.white, Color("background-color")]), startPoint: .top, endPoint: .bottom)
      VStack {
        
        Text("Pilih avatarmu!")
          .font(.custom(FontStyle.lexendMedium, size: 22))
        
        CardAvatar(imageWidth: 99, imageHeight: 151, avatar: avatars[0]).padding(.bottom, 11)
          .onTapGesture {
            avatar = avatars[0]
          }
          .overlay(avatar == avatars[0] ?
                   RoundedRectangle(cornerRadius: 25)
            .stroke(Color.red, lineWidth: 5).padding(.bottom, 11) :
                    RoundedRectangle(cornerRadius: 0)
            .stroke(Color.red, lineWidth: 0).padding(.bottom, 11))
        
        CardAvatar(imageWidth: 104, imageHeight: 115, avatar: avatars[1])
          .onTapGesture {
            avatar = avatars[1]
          }
          .padding(.bottom, 24)
          .overlay(avatar == avatars[1] ?
                   RoundedRectangle(cornerRadius: 25)
            .stroke(Color.red, lineWidth: 5).padding(.bottom, 24) :
                    RoundedRectangle(cornerRadius: 0)
            .stroke(Color.red, lineWidth: 0).padding(.bottom, 24))
        
        TextField(text: $name) {
          Text("Masukkan nama")
            .font(.custom(FontStyle.lexendMedium, size: 21))
        }
        .frame(maxWidth: .infinity, maxHeight: 75)
        .background(.white)
        .cornerRadius(38)
        .multilineTextAlignment(.center)
        .padding(.bottom, 11)
        
        Button {
          self.user.avatar = avatar
          self.user.name = name
          isGoToSpecificLetterView.toggle()
        } label: {
          Text("Buat Profile")
            .frame(maxWidth: .infinity, maxHeight: 75)
            .foregroundColor(.white)
            .font(.custom(FontStyle.lexendMedium, size: 21))
            .background(name.isEmpty ? Color.gray : Color.red)
            .cornerRadius(38)
          
        }
        .disabled(name.isEmpty ? true : false)
        
      }
      .padding([.horizontal], 20)
    }
    .navigationBarHidden(true)
    .ignoresSafeArea()
    .onAppear{
      avatar = avatars[0]
    }
    
    
    // Navigation
    NavigationLink(isActive: $isGoToSpecificLetterView, destination: {
      SpecificLettersView(user: user).environment(\.managedObjectContext, viewContext)
    }, label: {
      EmptyView()
    })
    
  }
}


//struct CreateUserView_Previews: PreviewProvider {
//    var user : UserController
//    @State var avatar : AvatarEntity
//  static var previews: some View {
//      CreateUserView(user: user, avatar: avatar)
//  }
//}
