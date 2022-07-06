//
//  UserService.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import Foundation
import SwiftUI

class UserService: ObservableObject {
    static let shared = UserService()
    init() {}

    func getReminderDate(user: UserEntity) -> String? {
        guard let date = user.reminder?.time else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yy")
        return dateFormatter.string(from: date)
    }

    func getReminderTime(user: UserEntity) -> String? {
        guard let date = user.reminder?.time else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        return dateFormatter.string(from: date)
    }
}
