//
//  LettersListView.swift
//  AlphaPlay WatchKit Extension
//
//  Created by erlina ng on 19/07/22.
//

import SwiftUI

struct LettersListView: View {
    @State private var listItemId: Int = 0
    @State private var visibleIds = [Int]()
    @State private var initialState = true
    @State private var isLoading = true
    @StateObject private var model = PhoneViewModel.shared
    @StateObject private var audioRecorder = AudioRecorderViewModel.shared

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                ZStack {
                    List(0 ..< Alphabet.allCases.count, id: \.self) { i in
                        LetterListItem(model: model, audioRecorder: audioRecorder, visibleIds: $visibleIds, i: i, listItemId: listItemId)
                    }
                    .listStyle(.carousel)
                    if isLoading {
                        ProgressView()
                            .background(.background)
                    }
                }
                .onChange(of: visibleIds) { newValue in
                    if newValue.count > 2 {
                        if newValue[2] == newValue[0] - 1 || newValue[2] == newValue[0] + 1 {
//                            reversal
                            listItemId = newValue[2]
                        } else {
                            if newValue.count > 3 {
                                if (newValue.last! == newValue[newValue.endIndex - 2] - 1 && newValue.last! == newValue[newValue.endIndex - 3] + 1)
                                    || (newValue.last! == newValue[newValue.endIndex - 2] - 1 && newValue.last! == newValue[newValue.endIndex - 3] - 1)
                                    || (newValue.last! == newValue[newValue.endIndex - 2] + 1 && newValue.last! == newValue[newValue.endIndex - 3] + 1)
                                    || (newValue.last! == newValue[newValue.endIndex - 2] + 1 && newValue.last! == newValue[newValue.endIndex - 3] - 1) {
//                                    reversal when scrolling with screen
                                    listItemId = newValue.last!
                                } else {
                                    //                                when scrolling with screen
                                    listItemId = newValue[2]
                                }
                            } else {
//                                normal
                                listItemId = newValue[1]
                            }
                        }
                    } else if newValue.count > 1 {
                        if newValue.first == 0 || newValue.first == Alphabet.allCases.count - 1 {
//                            first or last
                            listItemId = newValue[0]
                        } else {
//                            first or last after overflowing
                            listItemId = newValue[1]
                        }
                    } else if newValue.count > 0 {
//                        first or last when overflowing
                        listItemId = newValue[0]
                    } else {
//                        catch
                        listItemId = 0
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
    }
}

extension LettersListView {
    func initScroll(proxy: ScrollViewProxy) {
        let requiredVisibleIdxs = [[1, 0], [0, 1]]
        let animationDuration = 0.01
        proxy.scrollTo(Alphabet.allCases.count - 1)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(.linear(duration: animationDuration)) {
                proxy.scrollTo(0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 2 + 0.4) {
                guard !requiredVisibleIdxs.contains(visibleIds) else {
                    isLoading = false
                    return
                }
                initScroll(proxy: proxy)
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
