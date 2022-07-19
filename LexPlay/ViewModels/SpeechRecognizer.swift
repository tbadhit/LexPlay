//
//  SpeechRecognizer.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 27/06/22.
//

import AVFoundation
import Foundation
import Speech

class SpeechRecognizer: ObservableObject {
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnvailable

        var message: String {
            switch self {
            case .nilRecognizer:
                return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize:
                return "Not authorized to recognize speech"
            case .notPermittedToRecord:
                return "Not permitted to record audio"
            case .recognizerIsUnvailable:
                return "Recognizer is unavailable"
            }
        }
    }

    @Published var transcript: String = ""
    @Published var isRecoring: Bool = false
    @Published var isProcessing: Bool = false
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var recognizer: SFSpeechRecognizer?
    private let audioSession = AVAudioSession.sharedInstance()

    init() {
        recognizer = SFSpeechRecognizer(locale: Locale(identifier: "id-ID"))

        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                speakError(error)
            }
            do {
                _ = try prepareEngine()
            }
        }
    }

    deinit {
        cancelAndReset()
    }

    private func cancelAndReset() {
        task?.cancel()
        reset()
    }

    private func reset() {
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
        isRecoring = false
    }

    private func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true

        try audioSession.setCategory(.playAndRecord, mode: .default, options: .overrideMutedMicrophoneInterruption)
        try audioSession.overrideOutputAudioPort(.speaker)

        let audioEngine = AVAudioEngine()
        let inputNode = audioEngine.inputNode

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, _: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()

        return (audioEngine, request)
    }

    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil

        if receivedFinalResult || receivedError {
            isProcessing = false
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
        }

        if let result = result {
            speak(result.bestTranscription.formattedString)
        }
    }

    private func speak(_ message: String) {
        transcript = message
        print("You speak: \(transcript)")
    }

    private func speakError(_ error: Error) {
        isProcessing = false
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }

        transcript = "<< \(errorMessage) >>"
    }
}

extension SpeechRecognizer {
    func transcribe() {
        DispatchQueue.main.async {
            self.isRecoring = true
            self.transcript = ""
        }
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnvailable)
                return
            }

            do {
                let (audioEngine, request) = try self.prepareEngine()
                try self.audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                try audioEngine.start()
                self.audioEngine = audioEngine
                self.request = request
                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
                DispatchQueue.main.async {
                    self.isProcessing = true
                }
            } catch {
                self.cancelAndReset()
                self.speakError(error)
            }
        }
    }

    func stopTranscribing() {
        task?.finish()
        reset()
    }

    func isCorrect(alphabet: Alphabet) -> Bool {
        return alphabet.spellings.contains(transcript.lowercased())
    }
    
    func isCorrect(startsWith: Alphabet) -> Bool {
        return transcript.lowercased().starts(with: startsWith.rawValue.lowercased())
    }
}

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
