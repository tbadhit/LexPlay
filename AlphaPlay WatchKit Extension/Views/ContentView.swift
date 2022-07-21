//
//  ContentView.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Tubagus Adhitya Permana on 19/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
//            if UserDefaults.standard.hasOnboardedWatch {
//                ParentView(currentView: 2)
//            } else {
//                ParentView(currentView: 1).onAppear {
//                    UserDefaults.standard.hasOnboardedWatch = true
//                }
//            }
//            LettersListView()
            RecordingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
