//
//  CustomLessonAlphabetsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct CustomLessonAlphabetsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var alphabets: FetchedResults<UserAlphabetEntity>

    var body: some View {
        if alphabets.count > 0 {
            TabView {
                ForEach(alphabets) { alphabet in
                    VStack {
                        UserAlphabetCardView(alphabet: alphabet)
                        Spacer()
                    }
                }
                AlphabetPlusButtonView()
            }
            .tabViewStyle(.page)
        } else { EmptyView() }
    }

    init(user: UserEntity) {
        _alphabets = UserAlphabetRepository.getCustomPredicate(user: user)
    }
}

struct CustomLessonAlphabetsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLessonAlphabetsView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!)
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
