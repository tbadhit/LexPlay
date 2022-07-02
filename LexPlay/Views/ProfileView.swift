//
//  ProfileView.swift
//  LexPlay
//
//  Created by erlina ng on 02/07/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var boolNotification: Bool = true
    @State private var boolSavePhoto: Bool = true
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                        .padding()
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Hi, Name")
                                    .foregroundColor(Color("black"))
                                    .font(.custom(FontStyle.lexendMedium, size: 24))
                                    .fontWeight(.semibold)
                                    .offset(y: -10)
                                Text("Change Avatar")
                                    .foregroundColor(Color("red"))
                                    .font(.custom(FontStyle.lexendMedium, size: 16))
                                    .fontWeight(.medium)
                                    .offset(y: -5)
                            }
                            .frame(width: UIScreen.screenWidth / 2, alignment: .leading)
                            Image("play-avatar")
                                .frame(width: UIScreen.screenWidth / 3, alignment: .leading)
                        }
                        HStack {
                            Text("Username")
                            TextField("Username", text: $username)
                        }
                        .frame(width: UIScreen.screenWidth * 0.85,  alignment: .leading)
                    }
                }
                
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.28, alignment: .leading)
                
                ZStack {
                    Form {
                        Section() {
                            
                            Toggle(isOn: $boolNotification, label: {
                                Text("Notification")
                            })
                            Toggle(isOn: $boolSavePhoto, label: {
                                Text("Save Photo to Gallery")
                            })
                            //Ntr diganti destinationnya ke page lain
                            NavigationLink("Change Specific Difficulties", destination: Text("Hello, World!"))
                                .opacity(1)
                                
                            NavigationLink("Change Lesson Mode", destination: OnboardingView())
                                .opacity(1)
                        }
                    }
                    .background(Color.white)
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                    .cornerRadius(25)
                }
                .padding()
                .frame(height: UIScreen.screenHeight * 0.32)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                        .padding()
                    NavigationLink("Change Lesson Mode", destination: ListProfilesView())
                        .opacity(1)
                        .frame(width: UIScreen.screenWidth * 0.85, alignment: .leading)
                        .foregroundColor(.black)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.1, alignment: .leading)
                
                Spacer()
            }
            .background(Image("background"))
            .navigationBarHidden(true)

        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
