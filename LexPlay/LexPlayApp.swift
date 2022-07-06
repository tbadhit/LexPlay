//
//  LexPlayApp.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 25/06/22.
//

import SwiftUI

@main
struct LexPlayApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                //            Change the view
                //            ContentView()
                //          CameraView()
                //         AlphabetRecognitionView()
                //           LetterCaseView()
                //          UsersView()
                //          if UserDefaults.standard.hasOnboarded {
                //            MainView()
                //          } else {
//                            OnboardingView()
//                LessonsView(user: UserRepository(viewContext: persistenceController.container.viewContext).getActiveUser()!)
                //            CustomAlphabetView()
                //            CustomLessonsView()
                //          }
//            }
                OnboardingView()
                    .navigationBarHidden(true)
            }
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
