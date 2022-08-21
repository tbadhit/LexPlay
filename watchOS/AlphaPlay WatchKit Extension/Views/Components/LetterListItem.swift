//
//  LetterListItem.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 29/07/22.
//

import SwiftUI

struct LetterListItem: View {
    @ObservedObject var model: PhoneViewModel
    @ObservedObject var audioRecorder: AudioRecorderViewModel
    @Binding var visibleIds: [Int]
    @State var isTapped: Bool = false
    @State var isPresentingCover = false
    @State var errorMessage: String?
    @State var recognized: String?
    @State var isProcessing = false
    @State var shouldProcess = false

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
                    Image(systemName: "waveform")
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
            finalize()
        }, content: {
            if let errorMessage = errorMessage {
                VStack {
                    Text("Gagal.")
                        .font(.lexendBold())
                        .padding(.bottom, 4)
                    Text(errorMessage)
                }
            } else {
                if isProcessing {
                    VStack {
                        ProgressView()
                        Text("Memeriksa")
                    }
                } else {
                    ResultView(isCorrect: checkIsCorrect(word: recognized ?? "", startsWith: Alphabet.allCases[i]))
                }
            }
        })
        .onAppear {
            print("appear: \(Alphabet.allCases[i])")
            visibleIds = visibleIds.filter { $0 != i }
            visibleIds.insert(i, at: 0)
        }
        .onDisappear {
            print("disappear: \(Alphabet.allCases[i])")
            visibleIds = visibleIds.filter { $0 != i }
            finalize()
        }
        .onChange(of: visibleIds) { _ in
            isTapped = false
            endRecord()
        }
        .id(i)
        .listRowPlatterColor(.orange.opacity(isMain() ? 1 : 0.5))
    }
}

extension LetterListItem {
    func isMain() -> Bool {
        return listItemId == i
    }

    func checkIsCorrect(word: String, startsWith alphabet: Alphabet) -> Bool {
        let lowercasedWord = word.lowercased()
        return !alphabet.spellings.contains(lowercasedWord) && lowercasedWord.starts(with: alphabet.rawValue.lowercased())
    }

    func startRecord() {
        audioRecorder.startRecording()
    }

    func stopRecordAndSendAudio() {
        shouldProcess = true
        isProcessing = true
        isPresentingCover = isProcessing && isMain()
        audioRecorder.stopRecording()
        guard let url = audioRecorder.audioRecorder?.url else {
            promptError(message: "Gagal merekam")
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            promptError(message: "Gagal merekam")
            return
        }
        model.wcSession.sendMessageData(data) { replyData in
            guard shouldProcess else {
                finalize()
                return
            }
            if let recognized = String(data: replyData, encoding: .utf8) {
                print("Recognized: \(recognized)")
                self.recognized = recognized
                isProcessing = false
                shouldProcess = false
            } else {
                promptError(message: "Gagal mengenali")
            }
        } errorHandler: { error in
            guard shouldProcess else {
                finalize()
                return
            }
            print(error.localizedDescription)
            promptError(message: "Gagal memproses")
        }
    }

    func endRecord() {
        audioRecorder.stopRecording()
        finish()
    }

    func promptError(message: String) {
        errorMessage = message
        finish()
    }

    func finish() {
        recognized = nil
        isProcessing = false
        audioRecorder.finalize()
        shouldProcess = false
    }

    func finalize() {
        errorMessage = nil
        finish()
    }
}

struct LetterListItem_Previews: PreviewProvider {
    static var previews: some View {
        LetterListItem(model: PhoneViewModel.shared, audioRecorder: AudioRecorderViewModel.shared, visibleIds: .constant([0]), i: 0, listItemId: 0)
    }
}

fileprivate struct ResultView: View {
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
