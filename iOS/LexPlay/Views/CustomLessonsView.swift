//
//  CustomLessonsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct CustomLessonsView: View {
    @ObservedObject var guideViewModel = GuideViewModel.shared
    private let user: UserEntity

    var body: some View {
        VStack {
            MiniProfileView(user: user)
                .padding(.top, 32)
                .padding(.horizontal)
//            MiniReminderView(user: user)
//                .padding(.horizontal)
            CustomLessonAlphabetsView(user: user)
            Spacer()
        }
        .font(.custom(FontStyle.lexendMedium, size: 16))
        .scrollOnOverflow()
        .backgroundImage(Asset.background)
        .navigationBarHidden(true)
        .onDidAppear {
            guideViewModel.guidingAudios = [.alphabetCard, .alphabetCard__Alphabet, .alphabetCard__Speaker, .alphabetCard__Flip, .alphabetCard__Camera]
        }
        .onWillDisappear {
            guideViewModel.stopAndReset()
        }
    }

    init(user: UserEntity) {
        self.user = user
    }
}

struct CustomLessonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLessonsView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!)
            .font(.custom(FontStyle.lexendRegular, size: 16))
            .foregroundColor(Color("black"))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
