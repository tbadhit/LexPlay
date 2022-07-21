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
    //@Binding var isChangeAvatarViewPop : Bool

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
                    .stroke(Color.buttonAndSelectedtColor, lineWidth: 5):
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
//                    self.user.avatar = avatar
//                    do {
//                        try viewContext.save()
//                    } catch {
//
//                    }
                oldAvatar = avatar
                //self.isChangeAvatarViewPop = false
                
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
        .background(Image("background"))
        .padding(.horizontal, 20)
        .onAppear{
            avatar = oldAvatar
        }
    }
}

//struct ChangeAvatarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangeAvatarView()
//    }
//}
