//
//  ParentView.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Tubagus Adhitya Permana on 20/07/22.
//

import SwiftUI

struct ParentView: View {
    @State var currentView: Int = 1
    var body: some View {
        TabView(selection: $currentView) {
            OnboardingWatch().tag(1)
            TestSpeech().tag(2)
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
