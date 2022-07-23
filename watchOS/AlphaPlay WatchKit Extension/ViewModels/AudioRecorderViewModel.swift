//
//  AudioRecorderViewModel.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Muhamad Fahmi Al Kautsar on 21/07/22.
//

import Foundation
import AVFoundation

class AudioRecorderViewModel: ObservableObject {
    static let shared = AudioRecorderViewModel()
    @Published var recording = false
    var audioRecorder: AVAudioRecorder?
    private let audioSession = AVAudioSession.sharedInstance()

    private func prepare() throws {
        try audioSession.setCategory(.playAndRecord, mode: .default)
        try audioSession.setActive(true)
    }
    
    func startRecording() {
        stopRecording()
        do {
            try prepare()
        } catch {
            print(error.localizedDescription)
        }
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let audioFilename = documentPath.appendingPathComponent("\(Date().ISO8601Format()).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            recording = true
        } catch {
            print(error.localizedDescription)
            stopRecording()
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        do {
            try audioSession.setActive(false)
        } catch {
            print(error.localizedDescription)
        }
        recording = false
    }
}
