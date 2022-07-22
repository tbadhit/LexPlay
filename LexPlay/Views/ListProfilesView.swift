//
//  ListProfilesView.swift
//  LexPlay
//
//  Created by erlina ng on 02/07/22.
//

import SwiftUI

// A struct to store exactly one restaurant's data.
struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
}

// Buat Test
struct RestaurantRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        Text("Come and eat at \(restaurant.name)")
    }
}

struct ListProfilesView: View {
    
    private var users: [UserEntity]
    @ObservedObject var userActive: UserEntity
    @State private var username: String = ""
    @State private var userSelected: UserEntity? = nil
    @State private var isGoToAddNewUser: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                ForEach(users) {
                    user in
                    HStack {
                        Image(user.avatar?.path ?? "lex")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(user.name ?? "tidak ada nama")
                            .foregroundColor(Color("black"))
                            .font(.lexendSemiBold(17))
                        
                        Spacer()
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.screenWidth / 4.5)
                    .card()
                    .overlay(userActive == user ? RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.buttonAndSelectedtColor, lineWidth: 5):
                                RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.buttonAndSelectedtColor, lineWidth: 0))
                    .padding(.bottom, 30)
                    
                }
                
                Button(action: {
                    isGoToAddNewUser = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color("red"))
                        .font(.lexendBold(41))
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.screenHeight * 0.10)
                        .background(.white)
                        .cornerRadius(40)
                }
                
                NavigationLink(isActive: $isGoToAddNewUser) {
                    CreateUserView()
                } label: {
                    EmptyView()
                }

                
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
        .onAppear{
            print(users)
        }
        .backgroundImage(Asset.background)
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Text("Pilih").foregroundColor(.blue)
        }))
    }
    
    init(userActive: UserEntity) {
        self.users = UserRepository().getAllUsers()
        self.userActive = userActive
    }
}

//struct ListProfilesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListProfilesView()
//    }
//}
