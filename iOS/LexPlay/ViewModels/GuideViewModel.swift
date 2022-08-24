//
//  GuideViewModel.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 22/08/22.
//

import AVFAudio
import SwiftUI

class GuideViewModel: NSObject, AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate, ObservableObject {
    static let shared = GuideViewModel()
    private let audioService = AudioService()
    private var idx = 0
    var guidingAudios = [GuidingAudio]()
    var shouldPlay = false
    var timer: Timer?
    @Published var phase: CGFloat = 0
    @Published var guidedComponent: GuidingAudio? = nil
    @Published var isPlaying = false {
        didSet {
            guard shouldPlay, !isPlaying else { return }
            idx += 1
            guard idx < guidingAudios.count else {
                stopAudio()
                return
            }
            playAudio(name: guidingAudios[idx])
        }
    }

    deinit {
        stopAndReset()
    }

    func playAudio(name: GuidingAudio? = nil) {
        timer?.invalidate()
        if let name = name, let i = guidingAudios.firstIndex(of: name) {
            idx = i
        } else {
            idx = 0
        }
        guard guidingAudios.count > 0 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            self?.phase -= 20
        }
        guidedComponent = guidingAudios[idx]

        guard let guidedComponent = guidedComponent else {
            return
        }
        shouldPlay = true
        isPlaying = true
        audioService.speak(name: guidedComponent.rawValue)
        setDelegate()
    }

    func stopAudio() {
        audioService.stopSpeaking()
        shouldPlay = false
        idx = 0
        phase = 0
        guidedComponent = nil
        isPlaying = false
        timer?.invalidate()
    }

    func stopAndReset() {
        stopAudio()
        guidingAudios = []
    }

    func toggleAudio() {
        if isPlaying || shouldPlay {
            stopAudio()
        } else {
            playAudio()
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
        }
    }
}

extension GuideViewModel {
    private func setDelegate() {
        audioService.playerDelegate = self
        audioService.synthesizerDelegate = self
    }
}
