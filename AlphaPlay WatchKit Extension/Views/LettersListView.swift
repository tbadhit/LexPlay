//
//  LettersListView.swift
//  AlphaPlay WatchKit Extension
//
//  Created by erlina ng on 19/07/22.
//

import SwiftUI

struct LettersListView: View {
    @State private var listItemId: Int = 0
    @State private var visibleIds = [0, 1]
    @State private var initialState = true

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                List(0 ..< Alphabet.allCases.count, id: \.self) { i in
                    LetterItem(visibleIds: $visibleIds, i: i, listItemId: listItemId)
                }
                .listStyle(.carousel)
                .onChange(of: visibleIds) { newValue in
                    if newValue.count > 2 {
//                        reversal
                        if newValue[2] == newValue[0] - 1 || newValue[2] == newValue[0] + 1 {
                            listItemId = newValue[0]
                        } else {
                            listItemId = newValue[1]
                        }
                    } else if newValue.count > 1 {
                        listItemId = newValue[1]
                    }
                    print(newValue.map { Alphabet.allCases[$0].rawValue })
                }
                .onAppear {
                    guard initialState else { return }
                    initialState = false
                    initScroll(proxy: proxy)
                }
            }
        }
        .padding(.top, 0.4)
        .navigationTitle("AlphaPlay")
        .navigationBarTitleDisplayMode(.large)
    }

    func initScroll(proxy: ScrollViewProxy) {
        let requiredVisibleIdxs = [1, 0]
        let animationDuration = 0.001
        proxy.scrollTo(Alphabet.allCases.count - 1)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(.linear(duration: animationDuration)) {
                proxy.scrollTo(0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 2 + 0.5) {
                guard visibleIds != requiredVisibleIdxs else { return }
                //initScroll(proxy: proxy)
            }
        }
    }
}

struct LettersListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LettersListView()
        }
    }
}

struct LetterItem: View {
    @Binding var visibleIds: [Int]
    @State var isTapped : Bool = false
    var i: Int
    var listItemId: Int
    
    var body: some View {
        HStack {
            if !isTapped {
                Text("\(Alphabet.allCases[i].rawValue.uppercased())\(Alphabet.allCases[i].rawValue.lowercased())")
                    .frame(height: 120, alignment: .leading)
                    .font(.lexendBlack(40))
                Spacer()
                if listItemId == i {
                    Button {
                        isTapped.toggle()
                    } label: {
                    Image(systemName: "mic.fill")
                        .resizable()
                        .frame(width: 15, height: 25)
                        .scaledToFit()
                        .padding(.trailing, 20)
                    }
                }
            }
            if isTapped && listItemId == i {
                Button  {
                    isTapped.toggle()
                } label: {
                    Image("wave")
                        .resizable()
                        .frame(height: 85,alignment: .center)
                        .scaledToFit()
                        .padding(20)
                }
                    
            }
        }
        .task {
            visibleIds = visibleIds.filter { $0 != i }
            visibleIds.append(i)
        }.onDisappear {
            visibleIds = visibleIds.filter { $0 != i }
        }
        .id(i)
        .listRowPlatterColor(.indigo.opacity(listItemId == i ? 1 : 0.5))
    }
}

struct LetterItemBack : View {
    var i: Int
    var body: some View {
        Image("wave")
            .id(i)
            .listRowPlatterColor(.indigo)
    }
    
}
