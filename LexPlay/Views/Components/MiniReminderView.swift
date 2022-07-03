//
//  MiniReminderView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

struct MiniReminderView: View {
    let userController: UserController
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(userController.getReminderDate() ?? "DD/MM/YY")
                Text(userController.getReminderTime() ?? "00:00")
            }
            Spacer()
            Image(systemName: "bell.fill")
                .foregroundColor(Color("red"))
                .font(.title)
        }
        .cardPadding()
        .card()
    }
    
    init(userController: UserController = UserController()) {
        self.userController = userController
    }
}

struct MiniReminderView_Previews: PreviewProvider {
    static var previews: some View {
        MiniReminderView(userController: UserController(userRepository: UserRepository(viewContext: PersistenceController.preview.container.viewContext)))
            .background(Image("background"))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
