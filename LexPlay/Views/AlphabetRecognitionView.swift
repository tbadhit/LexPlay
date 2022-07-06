//
//  AlphabetRecognitionView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 27/06/22.
//

import SwiftUI

struct AlphabetRecognitionView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    private let alphabet: Alphabet = .b

    var body: some View {
        VStack {
            HStack {
                Button("Hold to speak") {}
                    .padding()
                    .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                        if pressing {
                            speechRecognizer.transcribe()
                        } else {
                            speechRecognizer.stopTranscribing()
                        }
                    }, perform: {})
                    .padding()
            }
            Text(speechRecognizer.isProcessing ? "Recognizing" : "Recognized")
            Text("You say:")
            Text(speechRecognizer.transcript)
            Text("Spell \(alphabet.rawValue.uppercased())!")
            Text(speechRecognizer.isCorrect(alphabet: alphabet) ? "correct" : "wrong")
        }
    }
}

struct RecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        AlphabetRecognitionView()
    }
}
