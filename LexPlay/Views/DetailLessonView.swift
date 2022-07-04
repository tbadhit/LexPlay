//
//  DetailLessonView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct DetailLessonView: View {
    private let lessonController: LessonController
    private let userController: UserController
    private let userAlphabetController: UserAlphabetController
    let lesson: LessonEntity

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Pelajaran \(lesson.name ?? "")")
                        .font(.lexendMedium(24))
                    Text("Gallery")
                }
                Spacer()
                HStack {
                    Image("bluey")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 88)
                        .padding(.bottom, -90)
                        .padding(.top, -64)
                        .padding(.trailing, -32)
                    Image("play-avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                        .padding(.bottom, -50)
                        .padding(.top, -16)
                        .padding(.trailing, -8)
                }
                .padding(.trailing, -32)
            }
            .padding()
            .padding(.horizontal, 24)
            .card()
            .cornerRadius(100)
            .padding(.horizontal)
            LessonAlphabetsView(userAlphabetController: userAlphabetController)
            Spacer()
        }
        .padding(.top)
        .font(.custom(FontStyle.lexendMedium, size: 16))
        .background(Image("background"))
    }

    init(lessonController: LessonController = LessonController(), userController: UserController = UserController(), userAlphabetController: UserAlphabetController = UserAlphabetController(),
         lesson: LessonEntity) {
        self.lessonController = lessonController
        self.userController = userController
        self.userAlphabetController = userAlphabetController
        self.lesson = lesson
    }
}

struct DetailLessonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLessonView(
            lessonController: LessonController(lessonRepository: LessonRepository(viewContext: PersistenceController.preview.container.viewContext), user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!),
            userController: UserController(userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)),
            userAlphabetController: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext), user: UserController(userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)).getUser()),
            lesson: LessonController(lessonRepository: LessonRepository(viewContext: PersistenceController.preview.container.viewContext), user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!).getLessons().first!
        )
        .font(.custom(FontStyle.lexendRegular, size: 16))
        .foregroundColor(Color("black"))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
