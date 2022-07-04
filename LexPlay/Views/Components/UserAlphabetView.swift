//
//  UserAlphabetView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct UserAlphabetView: View {
    private let userAlphabetController: UserAlphabetController
    private let alphabet: UserAlphabetEntity
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var showRecognizingResult = false
    @State private var popInfo = false

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
            Text(userAlphabetController.getChar(alphabet: alphabet) ?? "")
                .font(.custom(FontStyle.lexendBold, size: 180))
            Spacer()
            HStack {
                Button {
                    userAlphabetController.speak(alphabet: alphabet)
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
                              dismissButton: .default(Text("Oke")))
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

    init(userAlphabetController: UserAlphabetController = UserAlphabetController(userAlphabetRepository: UserAlphabetRepository()), alphabet: UserAlphabetEntity) {
        self.userAlphabetController = userAlphabetController
        self.alphabet = alphabet
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
        UserAlphabetView(userAlphabetController: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext),
                                                                        user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!),
                         alphabet: UserAlphabetController(userAlphabetRepository: UserAlphabetRepository(viewContext: PersistenceController.preview.container.viewContext),
                                                          user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!).getAlphabets()[0])
            .font(.custom(FontStyle.lexendRegular, size: 16))
            .foregroundColor(Color("black"))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
