//
//  CustomLessonAlphabetsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct CustomLessonAlphabetsView: View {
    private let userAlphabetController: UserAlphabetController
    @FetchRequest private var alphabets: FetchedResults<UserAlphabetEntity>

    var body: some View {
        if alphabets.count > 0 {
            TabView {
                ForEach(alphabets) { alphabet in
                    VStack {
                        UserAlphabetView(alphabet: alphabet)
                        Spacer()
                    }
                }
                AlphabetPlusButtonView()
            }
            .tabViewStyle(.page)
        } else { EmptyView() }
    }

    init(userAlphabetController: UserAlphabetController = UserAlphabetController(userAlphabetRepository: UserAlphabetRepository())) {
        self.userAlphabetController = userAlphabetController
        _alphabets = userAlphabetController.getPredicate()
    }
}

struct CustomLessonAlphabetsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLessonAlphabetsView(userAlphabetController: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext),
                                                                                 userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)))
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct AlphabetPlusButtonView: View {
    var body: some View {
        VStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .font(.lexendBold(180))
                        .foregroundColor(.brandPurple)
                    Spacer()
                }
                Spacer()
            }
            .padding(16)
            .card()
            .padding(.horizontal)
            .padding(.bottom, 48)
            Spacer()
        }
    }
}
