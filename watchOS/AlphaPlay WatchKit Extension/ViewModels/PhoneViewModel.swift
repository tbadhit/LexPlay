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

    init(session: WCSession = .default) {
        wcSession = session
        super.init()
        wcSession.delegate = self
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
    }
}
