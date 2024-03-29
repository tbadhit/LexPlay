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
    static let shared = SpeechRecognizer()
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
    @Published var isRecording: Bool = false
    @Published var isProcessing: Bool = false
    @Published var errorMessage: String?
    @Published var isError = false
    var shouldProcess = false
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var recognizer: SFSpeechRecognizer?
    private let audioSession = AVAudioSession.sharedInstance()
    private let speechRecognizerService = SpeechRecognizerService.shared

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
                cancelAndReset()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    deinit {
        cancelAndReset()
    }

    private func reset() {
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
        DispatchQueue.main.async {
            self.isRecording = false
        }
    }

    private func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest)? {
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true

        try audioSession.setCategory(.playAndRecord, mode: .default, options: .overrideMutedMicrophoneInterruption)
        try audioSession.overrideOutputAudioPort(.speaker)

        let audioEngine = AVAudioEngine()
        let inputNode = audioEngine.inputNode

        let recordingFormat = inputNode.outputFormat(forBus: 0)

        guard inputNode.inputFormat(forBus: 0).channelCount > 0 else {
            DispatchQueue.main.async {
                self.errorMessage = "NO_INPUT_NODE"
                self.isError = true
            }
            return nil
        }

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
            DispatchQueue.main.async {
                self.isProcessing = false
            }
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
        DispatchQueue.main.async {
            self.isProcessing = false
        }
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }

        DispatchQueue.main.async {
            self.transcript = "<< \(errorMessage) >>"
        }
    }
}

extension SpeechRecognizer {
    func transcribe() {
        shouldProcess = true
        DispatchQueue.main.async {
            self.isRecording = true
            self.transcript = ""
        }
        DispatchQueue(label: "Speech Recognizer Queue", qos: .userInteractive).async {
            guard let recognizer = self.recognizer, recognizer.isAvailable else {
                self.speakError(RecognizerError.recognizerIsUnvailable)
                return
            }

            do {
                guard self.shouldProcess else { return }
                guard let (audioEngine, request) = try self.prepareEngine() else {
                    self.speakError(RecognizerError.recognizerIsUnvailable)
                    return
                }
                guard self.shouldProcess else { return }
                try self.audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                try audioEngine.start()
                guard self.shouldProcess else { return }
                self.audioEngine = audioEngine
                self.request = request
                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
                DispatchQueue.main.async {
                    guard self.shouldProcess else { return }
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
        shouldProcess = false
    }

    func cancelAndReset() {
        task?.cancel()
        DispatchQueue.main.async {
            self.isProcessing = false
        }
        reset()
    }

    func isCorrect(alphabet: Alphabet) -> Bool {
        return speechRecognizerService.isCorrect(alphabet: alphabet, spoken: transcript)
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
