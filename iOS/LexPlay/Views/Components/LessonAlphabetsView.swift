//
//  LessonAlphabetsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct LessonAlphabetsView: View {
    let alphabets: FetchedResults<UserAlphabetEntity>
    let color: Color
    

    var body: some View {
        if alphabets.count > 0 {
            TabView {
                ForEach(alphabets) { alphabet in
                    VStack {
                        UserAlphabetCardView(alphabet: alphabet, color: color, isCustomLessonView: .constant(false))
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page)
        } else { EmptyView() }
    }
}

//struct LessonAlphabetsView_Previews: PreviewProvider {
//    static var previews: some View {
//        LessonAlphabetsView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!, lesson: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!.lessons!.toArray(of: LessonEntity.self).first!)
//            .font(.lexendRegular())
//            .foregroundColor(.brandBlack)
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
