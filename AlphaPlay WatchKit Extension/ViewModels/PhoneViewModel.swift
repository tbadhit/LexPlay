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
    //    var alphabetRecognition: AlphabetRecognitionDelegate?
    
//    AlphabetRecognizer
    @Published var recognized: String?
    @Published var isProcessing = false

    init(session: WCSession = .default) {
        wcSession = session
        super.init()
        wcSession.delegate = self
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let recognized = message["recognized"] as? String else { return }
        DispatchQueue.main.async {
            print("Recognized: \(recognized)")
            self.recognized = recognized
            self.isProcessing = false
//            self.alphabetRecognition?.setRecognized(recognized)
//            self.alphabetRecognition?.setIsProcessing(false)
        }
    }
}

extension PhoneViewModel {
    func finish() {
        recognized = nil
    }
}

//protocol AlphabetRecognitionDelegate {
//    func setRecognized(_ word: String)
//    func setIsProcessing(_ bool: Bool)
//}
