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
//            ProfileView()
//          UsersView()
//          if UserDefaults.standard.hasOnboarded {
//            MainView()
//          } else {
            OnboardingView()
//            LessonsView()
                .font(.custom(FontStyle.lexendRegular, size: 16))
                .foregroundColor(Color("black"))
                  .environment(\.managedObjectContext, persistenceController.container.viewContext)
//          }
        }
    }
}
