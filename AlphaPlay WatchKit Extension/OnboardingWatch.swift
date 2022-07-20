//
//  OnboardingWatch.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Tubagus Adhitya Permana on 19/07/22.
//

import SwiftUI

struct OnboardingWatch: View {
    
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "person.wave.2.fill")
                    .resizable()
                    .frame(width: 50, height: 43)
                
                
                Image(systemName: "mic.fill")
                    .frame(width: 50, height: 35)
                    .background(.indigo)
                    .cornerRadius(25)
                    .offset(x: 15, y: 28)
                
            }
            
            Spacer()
            
            Text("Tahan tombol dan\nsebutkan kata\ndengan awalan\nhuruf yang dipilih").font(.lexendRegular(17))
            
            
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("AlphaPlay")
            
        }
        .padding(.top, 10)
        
        
        
    }
}

struct OnboardingWatch_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OnboardingWatch()
            
                .navigationTitle("Hellow")
        }
    }
}
