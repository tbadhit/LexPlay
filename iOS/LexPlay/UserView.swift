//
//  UserView.swift
//  LexPlay
//
//  Created by erlina ng on 29/06/22.
//

import SwiftUI

struct UserView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (entity: UserEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users : FetchedResults<UserEntity>
    @State private var username: String = ""
    @State private var login:  String = ""
    @State private var timeStamp:  String = ""
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
            User().addUser(name: username, login: (login as NSString).boolValue, timeStamp: Double(timeStamp)!, moc: moc)
        }
        Button("EDIT") {
            User().editUsername(name: username, user: userSelected!, moc: moc)
        }
        
        List{
            Text("DISINI")
            ForEach(users) {
                user in
                VStack(alignment: .leading) {
                    Text(user.name ?? "")
                        .font(.headline)
                        .onTapGesture {
                            username = user.name ?? "gaada isi"
                            timeStamp = String(user.timestamp)
                            login = String(user.login)
                            userSelected = user
                        }
                    Text("\(String(user.login))")
                        .font(.subheadline)
                    Text("\(user.timestamp)")
                        .font(.subheadline)
                }
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
