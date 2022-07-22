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
                        LetterItem(model: model, audioRecorder: audioRecorder, visibleIds: $visibleIds, i: i, listItemId: listItemId)
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
        .navigationTitle("AlphaPlay")
        .navigationBarTitleDisplayMode(.large)
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

struct LetterItem: View {
    @ObservedObject var model: PhoneViewModel
    @ObservedObject var audioRecorder: AudioRecorderViewModel
    @Binding var visibleIds: [Int]
    @State var isTapped: Bool = false
    @State var isPresentingCover = false

    var i: Int
    var listItemId: Int

    var body: some View {
        HStack {
            if isTapped && isMain() {
                Text("\(Alphabet.allCases[i].rawValue.uppercased())\(Alphabet.allCases[i].rawValue.lowercased())")
                    .frame(height: 130, alignment: .leading)
                    .font(.lexendBlack(40))
                Spacer()
                Button {
                    stopRecordAndSendAudio()
                    isTapped = false
                } label: {
                    Image("wave")
                        .resizable()
//                        .frame(height: 85, alignment: .center)
                        .scaledToFit()
                        .padding(20)
                }
            } else {
                Text("\(Alphabet.allCases[i].rawValue.uppercased())\(Alphabet.allCases[i].rawValue.lowercased())")
                    .frame(height: 130, alignment: .leading)
                    .font(.lexendBlack(40))
                Spacer()
                if isMain() {
                    Button {
                        startRecord()
                        isTapped = true
                    } label: {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .frame(width: 15, height: 25)
                            .scaledToFit()
                            .padding(.trailing, 20)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isPresentingCover, onDismiss: {
            model.finish()
        }, content: {
            if model.isProcessing {
                VStack {
                    ProgressView()
                    Text("Memeriksa")
                }
            } else {
                ResultView(isCorrect: checkIsCorrect(word: model.recognized ?? "", startsWith: Alphabet.allCases[i]))
            }
        })
        .onAppear {
            visibleIds = visibleIds.filter { $0 != i }
            visibleIds.insert(i, at: 0)
        }
        .onDisappear {
            visibleIds = visibleIds.filter { $0 != i }
        }
        .onChange(of: visibleIds) { _ in
            isTapped = false
            endRecord()
        }
        .id(i)
        .listRowPlatterColor(.indigo.opacity(isMain() ? 1 : 0.5))
    }
}

extension LetterItem {
    func isMain() -> Bool {
        return listItemId == i
    }

    func checkIsCorrect(word: String, startsWith alphabet: Alphabet) -> Bool {
        return !alphabet.spellings.contains(word.lowercased()) && word.lowercased().starts(with: alphabet.rawValue.lowercased())
    }

    func startRecord() {
        audioRecorder.startRecording()
        model.shouldCommunicate = true
    }

    func stopRecordAndSendAudio() {
        model.isProcessing = true
        isPresentingCover = model.isProcessing && isMain()
        audioRecorder.stopRecording()
        guard let url = audioRecorder.audioRecorder?.url else {
            model.finish()
            return
        }
        model.wcSession.transferFile(url, metadata: [:])
    }

    func endRecord() {
        audioRecorder.stopRecording()
        model.finish()
    }
}

struct LetterItemBack: View {
    var i: Int
    var body: some View {
        Image("wave")
            .id(i)
            .listRowPlatterColor(.indigo)
    }
}

struct ResultView: View {
    let isCorrect: Bool

    var body: some View {
        VStack(spacing: 16) {
            if isCorrect {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .scaledToFit()
                    .foregroundColor(.green)
                Text("Benar!")
            } else {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .scaledToFit()
                    .foregroundColor(.red)
                Text("Coba lagi!")
            }
        }
        .font(.lexendMedium(24))
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResultView(isCorrect: false)
        }
    }
}
