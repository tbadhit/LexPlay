//
//  UserAlphabetsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct UserAlphabetsView: View {
    private let userAlphabetController: UserAlphabetController
    @FetchRequest private var alphabets: FetchedResults<UserAlphabetEntity>

    var body: some View {
        if alphabets.count > 0 {
            TabView {
                ForEach(alphabets) { alphabet in
                    VStack {
                        UserAlphabetView(userAlphabetController: userAlphabetController, alphabet: alphabet)
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page)
        } else { EmptyView() }
    }

    init(userAlphabetController: UserAlphabetController = UserAlphabetController(userAlphabetRepository: UserAlphabetRepository())) {
        self.userAlphabetController = userAlphabetController
        _alphabets = userAlphabetController.getPredicate()
    }
}

struct UserAlphabetsView_Previews: PreviewProvider {
    static var previews: some View {
        UserAlphabetsView(userAlphabetController: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext),
                                                                         user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!))
            .font(.custom(FontStyle.lexendRegular, size: 16))
            .foregroundColor(Color("black"))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
