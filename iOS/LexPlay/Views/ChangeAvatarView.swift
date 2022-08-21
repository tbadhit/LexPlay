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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var avatar: AvatarEntity?
    @Binding var oldAvatar: AvatarEntity?

    var body: some View {
        VStack {
            Text("Pilih Avatar")
                .font(.custom(FontStyle.lexendSemiBold, size: 24))

            CardAvatar(imageWidth: 99, imageHeight: 151, avatar: avatars[1])
                .onTapGesture {
                    avatar = avatars[1]
                }
                .overlay(avatar == avatars[1] ?
                    RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.buttonAndSelectedtColor, lineWidth: 5) :
                    RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.buttonAndSelectedtColor, lineWidth: 0))
                .padding(.bottom, 30)

            CardAvatar(imageWidth: 104, imageHeight: 115, avatar: avatars[0])
                .onTapGesture {
                    avatar = avatars[0]
                }
                .padding(.bottom, 24)
                .overlay(avatar == avatars[0] ?
                    RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.buttonAndSelectedtColor, lineWidth: 5).padding(.bottom, 24) :
                    RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.buttonAndSelectedtColor, lineWidth: 0).padding(.bottom, 24))
                .padding(.bottom, 70)

            Button {
                oldAvatar = avatar

                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Selesai")
                    .frame(maxWidth: .infinity, maxHeight: 75)
                    .foregroundColor(.white)
                    .font(.custom(FontStyle.lexendMedium, size: 21))
            }
            .background(Color.buttonAndSelectedtColor)
            .cornerRadius(38)

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 20)
        .backgroundImage(Asset.background)
        .onAppear {
            avatar = oldAvatar
        }
    }
}

// struct ChangeAvatarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangeAvatarView()
//    }
// }
