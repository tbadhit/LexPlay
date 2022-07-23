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

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \AvatarEntity.timestamp, ascending: true)],
                  animation: .default) private var avatars: FetchedResults<AvatarEntity>
    @State var avatar: AvatarEntity?
    @State var name = ""
    @State var isGoToSpecificLetterView = false

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Pilih avatarmu!")
                    .font(.custom(FontStyle.lexendMedium, size: 22))

                CardAvatar(imageWidth: 99, imageHeight: 151, avatar: avatars[0]).padding(.bottom, 11)
                    .onTapGesture {
                        avatar = avatars[0]
                    }
                    .overlay(avatar == avatars[0] ?
                        RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.buttonAndSelectedtColor, lineWidth: 5).padding(.bottom, 11) :
                        RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.buttonAndSelectedtColor, lineWidth: 0).padding(.bottom, 11))

                CardAvatar(imageWidth: 104, imageHeight: 115, avatar: avatars[1])
                    .onTapGesture {
                        avatar = avatars[1]
                    }
                    .padding(.bottom, 24)
                    .overlay(avatar == avatars[1] ?
                        RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.buttonAndSelectedtColor, lineWidth: 5).padding(.bottom, 24) :
                        RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.buttonAndSelectedtColor, lineWidth: 0).padding(.bottom, 24))

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
                        .background(name.isEmpty ? LinearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing) : Color.buttonAndSelectedtColor)
                        .cornerRadius(38)
                }
                .disabled(name.isEmpty ? true : false)

                if UserDefaults.standard.hasOnboarded {
                    Spacer()
                }
                Spacer()
            }
            .padding([.horizontal], 20)
            .backgroundImage(Asset.background)
            .navigationBarHidden(UserDefaults.standard.hasOnboarded ? false : true)
            .onAppear {
                avatar = avatars[0]
            }

            // Navigation
            NavigationLink(isActive: $isGoToSpecificLetterView, destination: {
                SpecificLettersView(user: user)
            }, label: {})
        }
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
