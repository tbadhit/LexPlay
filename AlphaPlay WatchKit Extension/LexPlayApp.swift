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
            ContentView()
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
