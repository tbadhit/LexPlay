//
//  TestView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 30/06/22.
//

import SwiftUI

struct TestView: View {
  // private var reminders: FetchedResults<ReminderEntity>
  @FetchRequest private var items: FetchedResults<UserAlphabetEntity>
  // private let reminderRepository: ReminderRepositoryProtocol
  private let ua: UserAlphabetRepositoryProtocol
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
  
  init() {
//    items = 
  }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
          .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
