//
//  WatchViewModel.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 21/07/22.
//

import SwiftUI
import WatchConnectivity

class WatchViewModel: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchViewModel()
    let wcSession: WCSession
    private let speechRecognizerService = SpeechRecognizerService()

    init(session: WCSession = .default) {
        wcSession = session
        super.init()
        wcSession.delegate = self
        session.activate()
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        speechRecognizerService.recognize(data: messageData) { result in
            switch result {
            case let .success(transcription):
                let spoken = transcription.bestTranscription.formattedString
                self.reply(result: spoken, replyHandler: replyHandler)
            case let .failure(error):
                self.reply(result: "", replyHandler: replyHandler)
                print(error.localizedDescription)
            }
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
    }

    func sessionDidDeactivate(_ session: WCSession) {
    }
}

extension WatchViewModel {
    private func reply(result: String, replyHandler: @escaping (Data) -> Void) {
        replyHandler(Data(result.utf8))
    }
}
