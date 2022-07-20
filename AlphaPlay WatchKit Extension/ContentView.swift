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
            LettersListView()
                .navigationTitle("AlphaPlay")
                .navigationBarTitleDisplayMode(.large)
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
