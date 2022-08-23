//
//  DetailLessonView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct DetailLessonView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewRouter: ViewRouter
    let user: UserEntity
    let lesson: LessonEntity

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Pelajaran \(lesson.name ?? "")")
                        .font(.lexendMedium(24))
                    Text("Galeri")
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
            LessonAlphabetsView(user: user, lesson: lesson)
                .environment(\.managedObjectContext, viewContext)
            Spacer()
        }
        .onAppear(perform: {
            viewRouter.currentPage = .detailLesson
        })
        .padding(.top)
        .font(.custom(FontStyle.lexendMedium, size: 16))
        .backgroundImage(Asset.background)
    }
}

#if DEBUG
    struct DetailLessonView_Previews: PreviewProvider {
        static var previews: some View {
            DetailLessonView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!, lesson: (UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()?.lessons?.toArray(of: LessonEntity.self).first)!)
                .font(.custom(FontStyle.lexendRegular, size: 16))
                .foregroundColor(Color("black"))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
#endif
