//
//  CustomLessonAlphabetsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct CustomLessonAlphabetsView: View {
    @Environment(\.managedObjectContext) private var viewContext
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

    init(predicate: FetchRequest<UserAlphabetEntity>, userAlphabetController: UserAlphabetController = UserAlphabetController(userAlphabetRepository: UserAlphabetRepository())) {
        _alphabets = predicate
        self.userAlphabetController = userAlphabetController
    }
}

struct CustomLessonAlphabetsView_Previews: PreviewProvider {
    static var previews: some View {
      CustomLessonAlphabetsView(predicate: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext), userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)).getPredicate(), userAlphabetController: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext),
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
