//
//  SpeechRecognizerService.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 21/07/22.
//

import Speech

class SpeechRecognizerService {
    static let shared = SpeechRecognizerService()

    func recognize(data: Data, completion: @escaping (Result<SFSpeechRecognitionResult, Error>) -> Void) {
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

        do {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent("tmp-speech-audio.m4a")
            try data.write(to: path)
            let request = SFSpeechURLRecognitionRequest(url: path)
            speechRecognizer?.supportsOnDeviceRecognition = true
            speechRecognizer?.recognitionTask(
                with: request,
                resultHandler: { result, error in
                    if let error = error {
                        print("Error recognizing")
                        print(error.localizedDescription)
                        completion(.failure(error))
                    } else if let result = result {
                        if result.isFinal {
                            print("iPhone recognized: \(result.bestTranscription.formattedString)")
                            completion(.success(result))
                        }
                    }
                    try? FileManager.default.removeItem(at: path)
                })
        } catch {
            completion(.failure(error))
        }
    }

    func isCorrect(alphabet: Alphabet, spoken: String) -> Bool {
        return alphabet.spellings.contains(spoken.lowercased())
    }
}
