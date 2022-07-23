//
//  AVAudioSession+Ext.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 21/07/22.
//

import AVFoundation

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
