//
//  AudioService.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import AVFoundation

class AudioService {
    static let shared = AudioService()
    var playerDelegate: AVAudioPlayerDelegate? {
        didSet {
            audio?.delegate = playerDelegate
        }
    }

    var synthesizerDelegate: AVSpeechSynthesizerDelegate? {
        didSet {
            synthesizer.delegate = synthesizerDelegate
        }
    }

    private var audio: AVAudioPlayer?
    private let synthesizer = AVSpeechSynthesizer()

    deinit {
        stopSpeaking()
    }

    func speak(_ str: String) {
        audio?.stop()
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        utterance.rate = 0.4
        utterance.pitchMultiplier = 0.5

        synthesizer.speak(utterance)
    }

    func speak(alphabet: AlphabetEntity?) {
        audio?.stop()
        guard let char = alphabet?.char else { return }
        speak("'\(char)'")
    }

    func speak(name: String, format: String = "m4a") {
        audio?.stop()
        guard let path = Bundle.main.path(forResource: name, ofType: format) else { return }
        do {
            audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audio?.play()
        } catch {
            print(error.localizedDescription)
        }
    }

    func stopSpeaking() {
        audio?.stop()
    }

    func isSpeaking() -> Bool {
        guard let audio = audio else { return false }
        return audio.isPlaying
    }
}
