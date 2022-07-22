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
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        print(file.description)
        speechRecognizerService.recognize(url: file.fileURL) { result in
            let spoken = result.bestTranscription.formattedString
            session.sendMessage(["recognized": spoken], replyHandler: nil, errorHandler: nil)
//            print(spoken)
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
    }

    func sessionDidDeactivate(_ session: WCSession) {
    }
}
