//
//  UserController.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import Foundation
import SwiftUI

class UserController {
    private let userRepository: UserRepositoryProtocol
    private let user: UserEntity

    init(userRepository: UserRepositoryProtocol = UserRepository(viewContext: PersistenceController.shared.container.viewContext)) {
        self.userRepository = userRepository
        user = userRepository.getActiveUser()!
    }

    func getUser() -> UserEntity {
        return user
    }

    func getReminderDate() -> String? {
        guard let date = user.reminder?.time else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yy")
        return dateFormatter.string(from: date)
    }

    func getReminderTime() -> String? {
        guard let date = user.reminder?.time else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        return dateFormatter.string(from: date)
    }
}
