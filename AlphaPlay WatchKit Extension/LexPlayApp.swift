//
//  LexPlayApp.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Tubagus Adhitya Permana on 19/07/22.
//

import SwiftUI

@main
struct LexPlayApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                if UserDefaults.standard.hasOnboardedWatch {
                    ParentView(currentView: 2)
                } else {
                    ParentView(currentView: 1).onAppear {
                        UserDefaults.standard.hasOnboardedWatch = true
                    }
                }
            }
        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
