//
//  RecordingView.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Muhamad Fahmi Al Kautsar on 21/07/22.
//

import SwiftUI

struct RecordingView: View {
//    @State var recognized: String?
//    @State var isProcessing: Bool = false
    
    @StateObject private var audioRecorder = AudioRecorderViewModel.shared
    @StateObject private var phoneModel = PhoneViewModel.shared

    var body: some View {
        VStack {
            if let recognized = phoneModel.recognized {
                Text(recognized)
                Text(checkIsCorrect(word: recognized, startsWith: .b) ? "Correct" : "Incorrect")
            }
            Text(String(audioRecorder.recording))
            HStack {
                Button("Record") {
                    startRecord()
                }
                Button("Stop") {
                    stopRecord()
                }
            }
        }
    }
    
//    init() {
//        phoneModel.alphabetRecognition = self
//    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}

extension RecordingView {
    func checkIsCorrect(word: String, startsWith: Alphabet) -> Bool {
        return word.lowercased().starts(with: startsWith.rawValue.lowercased())
    }

    func startRecord() {
        audioRecorder.startRecording()
    }

    func stopRecord() {
        audioRecorder.stopRecording()
//        phoneModel.isProcessing = true
        phoneModel.isProcessing = true
        guard let url = audioRecorder.audioRecorder?.url else {
            phoneModel.isProcessing = false
            return }
        phoneModel.wcSession.transferFile(url, metadata: [:])
//                    phoneModel.wcSession.sendMessageData(url.dataRepresentation) { data in
//                        print("F")
//                        print(data)
//                    }
    }
}

//extension RecordingView: AlphabetRecognitionDelegate {
//    func setRecognized(_ word: String) {
//        recognized = word
//    }
//    
//    func setIsProcessing(_ bool: Bool) {
//        isProcessing = bool
//    }
//}
