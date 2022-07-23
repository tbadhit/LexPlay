//
//  ContentView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 14/07/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var activeUsers: FetchedResults<UserEntity>

    var body: some View {
        NavigationView {
            VStack {
                if UserDefaults.standard.hasOnboarded, let user = activeUsers.first {
                    MainView(user: user)
                } else {
                    OnboardingView()
                }
            }
            .navigationBarHidden(true)
        }
    }

    init() {
        _activeUsers = UserRepository.getActiveUserPredicate()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
