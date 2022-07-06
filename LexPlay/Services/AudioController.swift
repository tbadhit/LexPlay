//
//  AudioController.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import AVFoundation

class AudioController {
    static let shared = AudioController()
    private let synthesizer = AVSpeechSynthesizer()

    func speak(_ str: String) {
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        utterance.rate = 0.4
        utterance.pitchMultiplier = 0.5

        synthesizer.speak(utterance)
    }

    func speak(alphabet: AlphabetEntity?) {
        guard let char = alphabet?.char else { return }
        speak("'\(char)'")
    }
}
