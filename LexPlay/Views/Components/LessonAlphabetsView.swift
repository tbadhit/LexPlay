//
//  LessonAlphabetsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct LessonAlphabetsView: View {
    private let userAlphabetController: UserAlphabetController
  private let lesson: LessonEntity
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
            }
            .tabViewStyle(.page)
        } else { EmptyView() }
    }

  init(lesson: LessonEntity, userAlphabetController: UserAlphabetController = UserAlphabetController(userAlphabetRepository: UserAlphabetRepository())) {
    self.lesson = lesson
        self.userAlphabetController = userAlphabetController
        _alphabets = userAlphabetController.getPredicateByLesson(lesson: lesson)
    }
}

//struct LessonAlphabetsView_Previews: PreviewProvider {
//    static var previews: some View {
//      LessonAlphabetsView(userAlphabetController: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext),
//                                                                           userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)))
//            .font(.lexendRegular())
//            .foregroundColor(.brandBlack)
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
