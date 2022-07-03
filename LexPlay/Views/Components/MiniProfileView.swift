//
//  MiniProfileView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

struct MiniProfileView: View {
    let userController: UserController
    let button: Button<Text>?

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 1) {
                    Text("Hi, \(userController.getUser().name ?? "")")
                        .font(.custom(FontStyle.lexendSemiBold, size: 24))
                        .offset(y: -5)
                    Text("Ayo Bermain!")
                }
                if let button = button {
                    button
                        .foregroundColor(Color("red"))
                }
            }
            .foregroundColor(Color("black"))
            Spacer()
            Image(userController.getUser().avatar?.path ?? "play-avatar")
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

    init(userController: UserController = UserController(), button: Button<Text>? = nil) {
        self.userController = userController
        self.button = button
    }
}

struct MiniProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MiniProfileView(userController: UserController(userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)), button: Button("Lihat Profil") {})
            .background(Image("background")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
