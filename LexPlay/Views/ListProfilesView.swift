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
    // @FetchRequest (entity: UserEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users : FetchedResults<UserEntity>
    var users = [
        Restaurant(name: "Joe's Original"),
        Restaurant(name: "The Real Joe's Original"),
        Restaurant(name: "Original Joe's"),
        Restaurant(name: "The Real Joe's OriginalThe Real Joe's OriginalThe Real Joe's OriginalThe Real Joe's Original"),
    ]
    @State private var username: String = ""
    @State private var userSelected: UserEntity?
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text("Profil")
                    .foregroundColor(Color("black"))
                    .font(.lexendSemiBold(28))
                    .frame(alignment: .topLeading)
                
                ForEach(users) {
                    user in
                    HStack {
                        Image("play-avatar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(user.name)
                            .foregroundColor(Color("black"))
                            .font(.lexendSemiBold(17))
                        
                        Spacer()
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.screenWidth / 4.5)
                    .card()
                    
                }
                
                Button(action: {
                    print("AA")
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color("red"))
                        .font(.custom(FontStyle.lexendMedium, size: 41).bold())
                    
                }
                .frame(maxWidth: .infinity, maxHeight: UIScreen.screenHeight * 0.10)
                .background(.white)
                .cornerRadius(40)
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
        
        .background(Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.top))
    }
}

struct ListProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ListProfilesView()
    }
}
