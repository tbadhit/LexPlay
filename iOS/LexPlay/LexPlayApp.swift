//
//  LexPlayApp.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 25/06/22.
//

import SwiftUI

@main
struct LexPlayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .font(.lexendRegular())
                .foregroundColor(.brandBlack)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

    init() {
        _ = WatchViewModel.shared
        UITableView.appearance().backgroundColor = .clear
    }
}
