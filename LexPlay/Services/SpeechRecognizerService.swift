//
//  SpeechRecognizerService.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 21/07/22.
//

import Speech

class SpeechRecognizerService {
    var audioPlayer: AVAudioPlayer?

    func recognize(url: URL, completion: @escaping (SFSpeechRecognitionResult) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .notDetermined: print("Not determined")
            case .restricted: print("Restricted")
            case .denied: print("Denied")
            case .authorized: print("We can recognize speech now.")
            @unknown default: print("Unknown case")
            }
        }

        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "id-ID"))

        func recognizeFromFile() {
            let request = SFSpeechURLRecognitionRequest(url: url)
            speechRecognizer?.supportsOnDeviceRecognition = true
            speechRecognizer?.recognitionTask(
                with: request,
                resultHandler: { result, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let result = result {
                        if result.isFinal {
                            completion(result)
                        }
                    }
                })
        }
        recognizeFromFile()
//        Play
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 0
            audioPlayer?.play()
            audioPlayer?.stop()
        } catch {
            print(error)
        }
    }
}
