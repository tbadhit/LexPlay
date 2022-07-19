//
//  ProfileView.swift
//  LexPlay
//
//  Created by erlina ng on 02/07/22.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //@FetchRequest private var users: FetchedResults<UserEntity>
    let user: UserEntity
    @State private var userRepository: UserRepository? = nil
    @State private var username: String = ""
    @State private var boolNotification: Bool = true
    @State private var boolSavePhoto: Bool = true
    //@State var user = UserModel()
    
    var body: some View {
        Form {
            //Section untuk User Info (Username & Avatar)
            Section {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hi, \(user.name ?? "")")
                                .foregroundColor(Color("black"))
                                .font(.custom(FontStyle.lexendMedium, size: 24))
                                .fontWeight(.semibold)
                                .offset(y: -5)
                            Text("Change Avatar")
                                .foregroundColor(Color("red"))
                                .font(.custom(FontStyle.lexendMedium, size: 16))
                                .fontWeight(.medium)
                                .offset(y: -5)
                            HStack {
                                Text("Username")
                                TextField("Username", text: $username)
                            }
                            .frame(width: UIScreen.screenWidth * 0.85, alignment: .leading)
                            .padding(.top, 25)
                        }
                        .frame(width: UIScreen.screenWidth / 2, alignment: .leading)
                        .padding(.top, -10)
                        
                        Image(user.avatar?.path ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth * 0.25, alignment: .leading)
                            .offset(x:-5)
                    }
                    
                    //                }
                    //                .background(Color.white)
                    //                .environment(\.horizontalSizeClass, .regular)
                    //                .cornerRadius(25)
                    //                .padding()
                    //                .frame(height: UIScreen.screenHeight * 0.32)
                }
                //.padding(.top, -60)
                
            }
                //Section Setting Option
            Section {
                Toggle(isOn: $boolNotification, label: {
                    Text("Notification")
                })
                Toggle(isOn: $boolSavePhoto, label: {
                    Text("Save Photo to Gallery")
                })
                
                // Ntr diganti destinationnya ke page lain
                NavigationLink("Change Specific Difficulties", destination: Text("Hello, World!").environment(\.managedObjectContext, viewContext))
                
                NavigationLink("Change Lesson Mode", destination: EmptyView().environment(\.managedObjectContext, viewContext))
            }
            .environment(\.horizontalSizeClass, .regular)
            .padding(.top, 10)
            .padding(.bottom, 10)
                
                //Section untuk switch profile
            Section {
                NavigationLink("Switch Profiles", destination: EmptyView().environment(\.managedObjectContext, viewContext))
            }
        }
        .background(Image("background"))
        .onAppear{
            userRepository = UserRepository(viewContext: viewContext)
        }
        .navigationBarItems(trailing:
            Button(action: {
            userRepository?.editUsername(name: username, user: user)
            print(user.name)
            print(username)
        }) {
                Text("Save")
            }
        )
            //.navigationBarHidden(true)
    }
    init(user: UserEntity) {
        self.user = user
        //_users = UserRepository.getActiveUser(userRepository!)
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
