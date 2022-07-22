//
//  ListProfilesView.swift
//  LexPlay
//
//  Created by erlina ng on 02/07/22.
//

import SwiftUI

struct ListProfilesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.name, ascending: true), NSSortDescriptor(keyPath: \UserEntity.login, ascending: true)], animation: .default)
    private var users: FetchedResults<UserEntity>
    @State private var selectedUserId: UUID?
    @State private var isUserChanged = false

    var body: some View {
        ZStack {
            if let user = users.first(where: { $0.uuid == selectedUserId }) {
                NavigationLink(isActive: $isUserChanged) {
                    NavigationLazyView(MainView(user: user))
                } label: {}
                    .isDetailLink(false)
                    .frame(width: 0, height: 0, alignment: .center)
            }
            VStack {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(users) { user in
                            Button {
                                selectedUserId = user.uuid
                            } label: {
                                HStack {
                                    Image(user.avatar?.path ?? "lex")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(.trailing)
                                        .padding(.top, 8)
                                    Text(user.name ?? "tidak ada nama")
                                        .foregroundColor(Color("black"))
                                        .font(.lexendSemiBold(17))

                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: UIScreen.screenWidth / 4.5)
                                .padding(.horizontal, 8)
                                .overlay(user.uuid == selectedUserId ? RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.buttonAndSelectedtColor, lineWidth: 8) :
                                    RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.buttonAndSelectedtColor, lineWidth: 0))
                                .card()
                            }
                        }
                    }
                }
                NavigationLink(destination: CreateUserView(), label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color("red"))
                        .font(.lexendBold(41))
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.screenHeight * 0.10)
                        .background(.white)
                        .cornerRadius(40)
                })
            }
            .padding(.horizontal)
            .backgroundImage(Asset.background)
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button(action: {
                guard let user = users.filter({ $0.uuid == selectedUserId }).first else { return }
                users.forEach { $0.login = false }
                user.login = true
                do {
                    try viewContext.save()
                } catch {
                    print("Failed to save user \(error.localizedDescription)")
                }
                isUserChanged = true
            }, label: {
                Text("Pilih").foregroundColor(.blue)
            }))
            .onAppear {
                guard let user = users.filter({ $0.login }).first else { return }
                selectedUserId = user.uuid
            }
        }
    }
}

struct ListProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListProfilesView()
                .font(.custom(FontStyle.lexendRegular, size: 16))
                .foregroundColor(Color("black"))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
