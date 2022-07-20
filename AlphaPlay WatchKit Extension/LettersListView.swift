//
//  LettersListView.swift
//  AlphaPlay WatchKit Extension
//
//  Created by erlina ng on 19/07/22.
//

import SwiftUI

struct LettersListView: View {
    @State private var opacitySet : Double = 0.5
    var body: some View {
        
//        List(Alphabet.allCases, id:\.self) {i in
//            Text("\(i.rawValue.uppercased())\(i.rawValue.lowercased())")
//                .frame(height: 100, alignment: .leading)
//                .font(.lexendBlack(40))
//                .listRowPlatterColor(Color("indigo"))
//        }
//        .listStyle(.carousel)
//        .navigationTitle("AlphaPlay")
        
        ScrollView {
            ForEach(Alphabet.allCases, id:\.self) {i in
                GeometryReader { geo in
                    HStack {
                        Text("\(i.rawValue.uppercased())\(i.rawValue.lowercased()) \(geo.frame(in: .global).minY)")
                            .frame(height: 80, alignment: .leading)
                            .font(.lexendBlack(40))
                            .padding(.leading, 15)
                            .onChange(of: geo.frame(in: .global).minY, perform: { newValue in
                                print("Huruf ke \(i.rawValue) punya height \(newValue)")
                            })
//                            .onAppear{
//                                print("Huruf ke \(i.rawValue) punya height \(geo.frame(in: .global).minY)")
//                            }
                        
                        //DItengah itu range 90-99
                        
                        Spacer()
                        
                        Image(systemName: "mic.fill")
                            .resizable()
                            .frame(width: 15, height: 25)
                            .scaledToFit()
                            .padding(.trailing, 20)
                            
                    }
                    .background(Color("indigo"))
                    .cornerRadius(25)
                    .opacity(0.5)
                }
                .frame(height: 80)
            }
            .navigationTitle("AlphaPlay")
        }
    }
}

struct LettersListView_Previews: PreviewProvider {
    static var previews: some View {
        LettersListView()
    }
}
