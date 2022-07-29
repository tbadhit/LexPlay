//
//  MiniReminderView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

struct MiniReminderView: View {
    private let userService = UserViewModel.shared
    @ObservedObject private var user: UserEntity

    var body: some View {
        NavigationLink(destination: ProfileView(user: user)) {
            HStack {
                VStack(alignment: .leading) {
//                    Text(userService.getReminderDate(user: user) ?? "DD/MM/YY")
                    Text(userService.getReminderTime(user: user) ?? "00:00")
                }
                Spacer()
                Image(systemName: "bell.fill")
                    .foregroundColor(user.reminder?.active ?? false ? Color.brandRed : Color.brandBlack)
                    .font(.title)
            }
        }
        .cardPadding()
        .card()
    }

    init(user: UserEntity) {
        self.user = user
    }
}

struct MiniReminderView_Previews: PreviewProvider {
    static var previews: some View {
        MiniReminderView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!)
            .backgroundImage(Asset.background)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
