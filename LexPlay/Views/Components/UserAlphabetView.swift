//
//  UserAlphabetView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct UserAlphabetView: View {
    private let audioController: AudioController = AudioController.shared
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var showRecognizingResult = false
    @State private var popInfo = false
    let alphabet: UserAlphabetEntity

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    popInfo.toggle()
                } label: { Image(systemName: "info.circle.fill")
                    .font(.title)
                    .foregroundColor(.brandPurple)
                }
                .popover(isPresented: $popInfo) {
                    HowToPlayView()
                }
            }
            Spacer()
            Text(alphabet.alphabet?.char ?? "")
                .font(.custom(FontStyle.lexendBold, size: 180))
            Spacer()
            HStack {
                Button {
                    audioController.speak(alphabet: alphabet.alphabet)
                } label: { Image(systemName: "speaker.wave.2.fill") }
                Button {} label: { Image(systemName: "mic.fill") }
                    .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                        if pressing {
                            speechRecognizer.transcribe()
                        } else {
                            speechRecognizer.stopTranscribing()
                            showRecognizingResult = true
                        }
                    }, perform: {})
                    .alert(isPresented: $showRecognizingResult) {
                        Alert(title: getAlertTitle(isProcessing: speechRecognizer.isProcessing),
                              message: getAlertMessage(isProcessing: speechRecognizer.isProcessing),
                              dismissButton: !speechRecognizer.isProcessing ? .default(Text("Oke")) : .default(Text("Batalkan")))
                    }
            }
            .font(.largeTitle)
            .foregroundColor(.brandPurple)
        }
        .padding(16)
        .card()
        .padding(.horizontal)
        .padding(.bottom, 48)
    }

    func getAlertTitle(isProcessing: Bool) -> Text {
        guard !isProcessing else {
            return Text("Tunggu...")
        }
        return getResult() ? Text("Benar!") : Text("Coba Lagi")
    }

    func getAlertMessage(isProcessing: Bool) -> Text {
        guard !isProcessing else {
            return Text("Sedang mengenali")
        }
        return (getResult() ? Text("🥳") : Text("🤔"))
    }

    private func getResult() -> Bool {
        guard let char = alphabet.alphabet?.char else { return false }
        guard let alphabet = Alphabet(rawValue: char) else { return false }
        return speechRecognizer.isCorrect(alphabet: alphabet)
    }
}

struct UserAlphabetView_Previews: PreviewProvider {
    static var previews: some View {
        UserAlphabetView(alphabet: UserAlphabetController(
            userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext),
            user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!
        ).getAlphabets()[0])
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
