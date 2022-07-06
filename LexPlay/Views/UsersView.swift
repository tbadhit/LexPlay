//
//  UserView.swift
//  LexPlay
//
//  Created by erlina ng on 29/06/22.
//

import SwiftUI

struct UsersView: View {
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<UserEntity>
    @State private var username: String = ""
    @State private var login: String = ""
    @State private var timeStamp: String = ""
    @State private var userSelected: UserEntity?

    var body: some View {
        TextField(
            "User name (email address)",
            text: $username
        )
        TextField(
            "Login (email address)",
            text: $login
        )
        TextField(
            "Timestamp (email address)",
            text: $timeStamp
        )

        Button("OK") {
//            UserRepository().addUser(name: username, login: (login as NSString).boolValue, timeStamp: Double(timeStamp)!)
        }
        Button("EDIT") {
            UserRepository().editUsername(name: username, user: userSelected!)
        }

        List {
            Text("DISINI")
            ForEach(users) {
                _ in
                VStack(alignment: .leading) {
//                    Text(user.name ?? "")
//                        .font(.headline)
//                        .onTapGesture {
//                            username = user.name ?? "gaada isi"
//                            timeStamp = String(user.timestamp)
//                            login = String(user.login)
//                            userSelected = user
//                        }
//                    Text("\(String(user.login))")
//                        .font(.subheadline)
//                    Text("\(user.timestamp)")
//                        .font(.subheadline)
                }
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
