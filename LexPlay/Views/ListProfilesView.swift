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
            ZStack(alignment: .top) {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Profiles")
                        .foregroundColor(Color("black"))
                        .font(.custom(FontStyle.lexendMedium, size: 28))
                        .fontWeight(.semibold)
                        .frame(alignment: .topLeading)
                        .padding()
                        .padding(.top, UIScreen.screenHeight * 0.05)

                    ForEach(users) {
                        user in
                        VStack(alignment: .center) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40, style: .continuous)
                                    .fill(.white)

                                HStack {
                                    Image("play-avatar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text(user.name)
                                        .foregroundColor(Color("black"))
                                        .font(.custom(FontStyle.lexendMedium, size: 17))
                                        .fontWeight(.semibold)
                                }

                                .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * 0.085, alignment: .leading)
                            }
                            .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.1)
                        }
                        .padding(.leading, 20)
                    }

                    ZStack {
                        RoundedRectangle(cornerRadius: 40, style: .continuous)
                            .fill(.white)

                        HStack {
                            Button(action: {
                                print("AA")
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color("red"))
                                    .font(.custom(FontStyle.lexendMedium, size: 41).bold())
                            }
                        }
                        .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * 0.085, alignment: .center)
                    }

                    .padding(.leading, 20)
                    .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenHeight * 0.09)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }
            .navigationBarHidden(true)
    }
}

struct ListProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ListProfilesView()
    }
}
