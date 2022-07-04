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
//            Change the view
//            ContentView()
//          CameraView()
//         AlphabetRecognitionView()
//           LetterCaseView()
//          UsersView()
//          if UserDefaults.standard.hasOnboarded {
//            MainView()
//          } else {
//            OnboardingView()
            LessonsView()
//            CustomLessonsView()
                .font(.lexendRegular())
                .foregroundColor(Color("black"))
                  .environment(\.managedObjectContext, persistenceController.container.viewContext)
//          }
        }
    }
}
