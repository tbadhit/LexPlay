//
//  MainView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 22/07/22.
//

import SwiftUI

struct MainView: View {
    let user: UserEntity

    var body: some View {
        if user.isLearnCustomLesson {
            CustomLessonsView(user: user)
        } else {
            LessonsView(user: user)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!)
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
