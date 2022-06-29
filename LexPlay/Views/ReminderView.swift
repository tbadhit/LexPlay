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
    
    var body: some View {
        VStack {
            
            DatePicker("Pick Your Time", selection: $currentDate, displayedComponents: [.hourAndMinute]).labelsHidden()
            
            Text("You've picked \(currentDate)")
            
            
            Button("Add Notification") {

                ReminderNotification().addNotification(currentDate: currentDate)
            }
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
