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
            ProfileView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//          UsersView()
//          if UserDefaults.standard.hasOnboarded {
//            MainView()
//          } else {
            OnboardingView()
                  .environment(\.managedObjectContext, persistenceController.container.viewContext)
//          }
        }
    }
}
