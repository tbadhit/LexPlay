//
//  TestView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 30/06/22.
//

import SwiftUI

struct TestView: View {
  // private var reminders: FetchedResults<ReminderEntity>
  
  @FetchRequest private var userAlphabets: FetchedResults<UserAlphabetEntity>
  private let userAlphabetRepository: UserAlphabetRepositoryProtocol
  
    var body: some View {
      List {
        ForEach(userAlphabets) { ua in
          Image(uiImage: UIImage(data: ua.imageAssociation!)!)
            .resizable()
            .frame(width: 100, height: 300)
        }
      }
    }
}

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//          .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
