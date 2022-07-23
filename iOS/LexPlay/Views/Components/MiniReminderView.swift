//
//  MiniReminderView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

struct MiniReminderView: View {
    private let userService = UserViewModel.shared
    private let user: UserEntity

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(userService.getReminderDate(user: user) ?? "DD/MM/YY")
                Text(userService.getReminderTime(user: user) ?? "00:00")
            }
            Spacer()
            Image(systemName: "bell.fill")
                .foregroundColor(Color("red"))
                .font(.title)
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
