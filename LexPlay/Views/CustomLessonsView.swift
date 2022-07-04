//
//  CustomLessonsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct CustomLessonsView: View {
    private let lessonController: LessonController
    private let userController: UserController
    private let userAlphabetController: UserAlphabetController

    var body: some View {
        VStack {
            MiniProfileView(userController: userController, button: Button("Lihat Profil") {})
                .padding(.top, 32)
                .padding(.horizontal)
            MiniReminderView(userController: userController)
                .padding(.horizontal)
            UserAlphabetsView(userAlphabetController: userAlphabetController)
            Spacer()
        }
        .font(.custom(FontStyle.lexendMedium, size: 16))
        .background(Image("background"))
    }

    init(lessonController: LessonController = LessonController(), userController: UserController = UserController(), userAlphabetController: UserAlphabetController = UserAlphabetController()) {
        self.lessonController = lessonController
        self.userController = userController
        self.userAlphabetController = userAlphabetController
    }
}

struct CustomLessonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLessonsView(
            lessonController: LessonController(lessonRepository: LessonRepository(viewContext: PersistenceController.preview.container.viewContext), user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!),
            userController: UserController(userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)),
            userAlphabetController: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext), user: UserController(userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)).getUser())
        )
        .font(.custom(FontStyle.lexendRegular, size: 16))
        .foregroundColor(Color("black"))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
