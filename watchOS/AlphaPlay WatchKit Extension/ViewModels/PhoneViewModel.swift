//
//  PhoneViewModel.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Muhamad Fahmi Al Kautsar on 21/07/22.
//

import WatchConnectivity

class PhoneViewModel: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = PhoneViewModel()
    let wcSession: WCSession

//    AlphabetRecognizer
    @Published var recognized: String?
    @Published var isProcessing = false
    @Published var shouldCommunicate = false

    init(session: WCSession = .default) {
        wcSession = session
        super.init()
        wcSession.delegate = self
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        guard let recognized = message["recognized"] as? String else { return }
        DispatchQueue.main.async {
            print("Recognized: \(recognized)")
            guard self.shouldCommunicate else { return }
            self.recognized = recognized
            self.isProcessing = false
        }
    }
}

extension PhoneViewModel {
    func finish() {
        recognized = nil
        isProcessing = false
        shouldCommunicate = false
    }
}
