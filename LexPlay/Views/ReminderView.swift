//
//  ReminderView.swift
//  LexPlay
//
//  Created by erlina ng on 28/06/22.
//

import SwiftUI
import UserNotifications

struct ReminderView: View {
    @State private var currentDate = Date()
    @State private var isActive = false
    @FetchRequest private var reminders: FetchedResults<ReminderEntity>
    private let reminderRepository: ReminderRepositoryProtocol
    
    var body: some View {
        VStack {
            
            DatePicker("Pick Your Time", selection: $currentDate, displayedComponents: [.hourAndMinute]).labelsHidden()
            
            Text("You've picked \(currentDate)")
            
            
            Button("Add Notification") {

                ReminderNotification().addNotification(currentDate: currentDate)
            }
            Toggle(isOn: $isActive) {
                Text("Notification")
            }
            .onChange(of: isActive) { value in
                reminderRepository.update(reminder: reminders[0], isActive: value, time: currentDate)
            }
        }
        .onAppear {
            let reminder = reminders[0]
            currentDate = reminder.time ?? Date()
            isActive = reminder.active
        }
    }
    
    init(user: UserEntity = UserRepository().getActiveUser()!, reminderRepository: ReminderRepositoryProtocol = ReminderRepository()) {
        self.reminderRepository = reminderRepository
        _reminders = reminderRepository.getPredicate(user: user)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(
            user: DummyUserRepository().getActiveUser()!,
            reminderRepository: DummyReminderRepository())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
