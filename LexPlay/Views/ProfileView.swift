//
//  ProfileView.swift
//  LexPlay
//
//  Created by erlina ng on 02/07/22.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var user: UserEntity
    @State private var userRepository: UserRepository? = nil
    @State private var username: String = ""
    @State private var currentDate = Date()
    @State private var boolNotification: Bool = true
    @State private var boolSavePhoto: Bool = true
    @State private var isGoToChangeAvatar : Bool = false
    private var reminderNotification: ReminderNotification?
    @State var avatar: AvatarEntity?
    
    var body: some View {
        
        Form {
            //Section untuk User Info (Username & Avatar)
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hai, \(user.name ?? "")")
                            .foregroundColor(Color("black"))
                            .font(.custom(FontStyle.lexendMedium, size: 24))
                            .fontWeight(.semibold)
                            .offset(y: -5)
                        
                        ZStack(alignment: .leading) {
                            Button {
                                isGoToChangeAvatar.toggle()
                            } label: {
                                Text("Ubah Avatar")
                                    .foregroundColor(Color("red"))
                                    .font(.custom(FontStyle.lexendMedium, size: 16))
                                    .fontWeight(.medium)
                            }
                            
                            NavigationLink(isActive: $isGoToChangeAvatar, destination: {
                                ChangeAvatarView(oldAvatar: $avatar).environment(\.managedObjectContext, viewContext)
                            }, label: {
                                EmptyView()
                            })
                            .opacity(0.0)
                        }
                        .offset(y: -5)
                        
                        
                        HStack {
                            Text("Ubah nama")
                            TextField("...", text: $username)
                        }
                        .frame(width: UIScreen.screenWidth * 0.85, alignment: .leading)
                        .padding(.top, 25)
                    }
                    .padding(.top, -10)
                    .frame(width: UIScreen.screenWidth / 2, alignment: .leading)
                    
                    Image(avatar?.path ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.screenWidth * 0.25, alignment: .leading)
                        .offset(x:-5)
                }
                .frame(height: UIScreen.screenWidth / 2.5, alignment: .leading)
                
            }
            //Section Setting Option
            Section {
                Toggle(isOn: $boolNotification, label: {
                    Text("Notifikasi")
                })
                
                if boolNotification {
                    DatePicker("Pick Your Time", selection: $currentDate, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                }
                
                Toggle(isOn: $boolSavePhoto, label: {
                    Text("Simpan foto ke galeri")
                })
                
                // Ntr diganti destinationnya ke page lain
                NavigationLink("Change Specific Difficulties", destination: Text("Hello, World!").environment(\.managedObjectContext, viewContext))
                
                NavigationLink("Ubah mode pelajaran", destination: EmptyView().environment(\.managedObjectContext, viewContext))
            }
            .environment(\.horizontalSizeClass, .regular)
            .padding(.top, 10)
            .padding(.bottom, 10)
            
            //Section untuk switch profile
            Section {
                NavigationLink("Ganti profile", destination: ListProfilesView().environment(\.managedObjectContext, viewContext))
            }
        }
        .font(.lexendMedium())
        .background(Image("background"))
        .onAppear{
            userRepository = UserRepository(viewContext: viewContext)
            if avatar == nil {
                avatar =  user.avatar
            }
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().isScrollEnabled = false
            boolNotification = user.reminder!.active
        }
        .navigationBarItems(trailing:
                                Button(action: {
            if username == "" {
                username = user.name!
            }
            userRepository?.editUser(name: username,avatar: avatar!,  user: user)
            userRepository?.turnNotification(user: user, active: boolNotification)
            if boolNotification {
                reminderNotification?.toggleNotification(entity: user.reminder! , time: currentDate, isActive: boolNotification)
                print("AAAAA")
            }
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Simpan").foregroundColor(.blue)
        }
        )
        //.navigationBarHidden(true)
    }
    init(user: UserEntity) {
        self.user = user
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
