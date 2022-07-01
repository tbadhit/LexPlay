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
         AlphabetRecognitionView()
            // ReminderView(reminderNotification: ReminderNotification())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
