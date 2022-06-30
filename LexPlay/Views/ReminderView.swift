//
//  ReminderView.swift
//  LexPlay
//
//  Created by erlina ng on 28/06/22.
//

import SwiftUI
import UserNotifications

struct ReminderView: View {
    private var reminderNotification: ReminderNotification
    @State private var currentDate = Date()
    @State private var isActive = false
    @FetchRequest private var reminders: FetchedResults<ReminderEntity>

    var body: some View {
        VStack {
            DatePicker("Pick Your Time", selection: $currentDate, displayedComponents: [.hourAndMinute]).labelsHidden()

            Text("You've picked \(currentDate)")

            Toggle(isOn: $isActive) {
                Text("Notification")
            }
            .onChange(of: isActive) { value in
                if let reminder = reminders.first {
                    reminderNotification.toggleNotification(entity: reminder, time: currentDate, isActive: value)
                }
            }
        }
        .onAppear {
            if let reminder = reminders.first {
                currentDate = reminder.time ?? Date()
                isActive = reminder.active
            }
        }
    }

    init(reminderNotification: ReminderNotification) {
        self.reminderNotification = reminderNotification
        _reminders = reminderNotification.getPredicate()
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(
            reminderNotification: ReminderNotification(user: DummyUserRepository().getActiveUser()!, reminderRepository: DummyReminderRepository()))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
