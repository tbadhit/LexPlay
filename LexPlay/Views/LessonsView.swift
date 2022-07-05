//
//  LessonsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

struct LessonsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    private let lessonController: LessonController
    private let userController: UserController
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
    private let images: [(String, CGFloat, CGFloat, CGFloat)] = [
        ("bluey", CGFloat(100), CGFloat(-16), CGFloat(-16)),
        ("orangey", CGFloat(171), CGFloat(-32), CGFloat(-70)),
        ("limey", CGFloat(125), CGFloat(-80), CGFloat(-30)),
        ("cyany", CGFloat(125), CGFloat(-32), CGFloat(-32)),
        ("er", CGFloat(261), CGFloat(-20), CGFloat(-16)),
    ]

    var body: some View {
        VStack {
            MiniProfileView(userController: userController, button: Button("Lihat Profil") {})
                .padding(.top, 32)
                .padding(.bottom, 8)
                .padding(.horizontal)
            MiniReminderView(userController: userController)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                Text("Pelajaran")
                    .font(.custom(FontStyle.lexendSemiBold, size: 24))
                    .padding(.horizontal)
                    .padding(.top, 8)
                TabView {
                    VStack {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(0 ..< (lessonController.getLessons().count > 4 ? 4 : lessonController.getLessons().count), id: \.self) { i in
                                getNavLink(i: i)
                            }
                        }
                        .padding(.horizontal)
                        Spacer()
                    }

                    if lessonController.getLessons().count > 4 {
                        getNavLink(i: 4)
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(.page)
            }
            Spacer()
        }
        .font(.custom(FontStyle.lexendMedium, size: 16))
        .background(Image("background"))
        .navigationBarHidden(true)
    }

    func getNavLink(i: Int) -> some View {
        return NavigationLink(destination: DetailLessonView(lessonController: lessonController, userController: userController, userAlphabetController: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: viewContext), user: userController.getUser()), lesson: lessonController.getLessons()[i])
            .navigationBarTitle("", displayMode: .inline)
            .environment(\.managedObjectContext, viewContext)) {
            LessonItemView(i: i, image: images[i])
        }
    }

    init(lessonController: LessonController = LessonController(), userController: UserController = UserController()) {
        self.lessonController = lessonController
        self.userController = userController
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LessonsView(lessonController: LessonController(lessonRepository: LessonRepository(viewContext: PersistenceController.preview.container.viewContext), user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!),
                        userController: UserController(userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

struct LessonItemView: View {
    let i: Int
    let image: (String, CGFloat, CGFloat, CGFloat)

    var body: some View {
        VStack {
            HStack {
                Image(image.0)
                    .resizable()
                    .scaledToFit()
                    .frame(width: image.1)
                    .padding(.bottom, image.2)
                    .padding(.leading, image.3)
                Spacer()
                Text(String(i + 1))
                    .font(.custom(FontStyle.lexendSemiBold, size: 64))
                    .foregroundColor(Color("black"))
            }
            .padding(.trailing, 16)
            .padding(.top, 16)
            .frame(height: UIScreen.screenWidth / 2.5)
            .card()
            Spacer()
        }
    }
}
