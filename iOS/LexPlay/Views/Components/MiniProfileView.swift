//
//  MiniProfileView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

struct MiniProfileView: View {
    @ObservedObject var user: UserEntity

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 1) {
                    Text("Hai, \(user.name ?? "")")
                        .font(.custom(FontStyle.lexendSemiBold, size: 24))
                        .offset(y: -5)
                    Text("Ayo Bermain!")
                }
                NavigationLink(destination: QuizView()) {
                    Text("Lihat Profil")
                        .foregroundColor(Color("red"))
                }
            }
            .foregroundColor(Color("black"))
            Spacer()
            Image(user.avatar?.path ?? "play-avatar")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
                .offset(y: 14)
        }
        .font(.custom(FontStyle.lexendMedium, size: 16))
        .padding(.bottom, -12)
        .cardPadding()
        .card()
    }

    init(user: UserEntity) {
        self.user = user
    }
}

//struct MiniProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        MiniProfileView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!)
//            .backgroundImage(Asset.background).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
