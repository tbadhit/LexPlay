//
//  LettersListView.swift
//  AlphaPlay WatchKit Extension
//
//  Created by erlina ng on 19/07/22.
//

import SwiftUI

struct LettersListView: View {
    @State private var idx: Int = 0
    @State private var oldIdx: Int = 0
    @State private var currentAlphabet: Alphabet = .a
    
    var body: some View {
        ScrollViewReader { _ in
            VStack {
                List(0 ..< Alphabet.allCases.count, id: \.self) { i in
                    HStack {
                        Text("\(Alphabet.allCases[i].rawValue.uppercased())\(Alphabet.allCases[i].rawValue.lowercased())")
                            .frame(height: 100, alignment: .leading)
                            .font(.lexendBlack(40))
                        Spacer()
                        if currentAlphabet == Alphabet.allCases[i] {
                            Image(systemName: "mic.fill")
                                .resizable()
                                .frame(width: 15, height: 25)
                                .scaledToFit()
                                .padding(.trailing, 20)
                        }
                    }
                    .listRowPlatterColor(Color("indigo"))
//                    .onDisappear {
//                        if idx > i {
//                            print(Alphabet.allCases[i+1])
//                        } else {
//                            print(Alphabet.allCases[i-1])
//                        }
//                        idx = i
//                    }
                    .id(i)
                    .task(id: i) {
//                                idx = i
//                                print(Alphabet.allCases[i])
//                                if oldIdx == 0 {
//                                    currentAlphabet = Alphabet.allCases[0]
//                                } else if oldIdx == Alphabet.allCases.count - 1 {
//                                    currentAlphabet = Alphabet.allCases[Alphabet.allCases.count - 1]
//                                } else
                        if oldIdx > i {
    //                        print("up")
                            currentAlphabet = Alphabet.allCases[i + 1]
    //                        print(Alphabet.allCases[newValue + 1])
                        } else {
    //                        print("down")
                            currentAlphabet = Alphabet.allCases[i - 1]
    //                        print(Alphabet.allCases[newValue - 1])
                        }
                        oldIdx = i
                    }
                    //.background(Color("indigo"))
                }
                .listStyle(.carousel)
                .navigationTitle("AlphaPlay")
            }
        }
    }
}

struct LettersListView_Previews: PreviewProvider {
    static var previews: some View {
        LettersListView()
    }
}
