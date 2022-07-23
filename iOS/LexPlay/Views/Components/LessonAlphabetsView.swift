//
//  LessonAlphabetsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct LessonAlphabetsView: View {
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
            }
            .tabViewStyle(.page)
        } else { EmptyView() }
    }

    init(user: UserEntity, lesson: LessonEntity) {
        _alphabets = UserAlphabetRepository.getByLessonPredicate(user: user, lesson: lesson)
    }
}

struct LessonAlphabetsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonAlphabetsView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!, lesson: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!.lessons!.toArray(of: LessonEntity.self).first!)
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
