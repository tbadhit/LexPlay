//
//  OnboardingWatch.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Tubagus Adhitya Permana on 19/07/22.
//

import SwiftUI

struct OnboardingWatch: View {
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image(systemName: "person.wave.2.fill")
                        .resizable()
                        .frame(width: 50, height: 43)

                    Image(systemName: "mic.fill")
                        .frame(width: 50, height: 35)
                        .background(.orange)
                        .cornerRadius(25)
                        .offset(x: 15, y: 28)
                }
                .padding(.bottom, 24)

                Spacer()

                Text("Sambil membuka\nLexPlay di iPhone,\ntekan tombol\ndan sebutkan 1 kata\ndengan awalan huruf\nyang dipilih")
                    .font(.lexendRegular(17))
            }
            .padding(.top, 10)
        }
    }
}

struct OnboardingWatch_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OnboardingWatch()
        }
    }
}
