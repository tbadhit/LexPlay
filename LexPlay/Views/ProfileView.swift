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
    @State private var isNotificationOn: Bool = true
    @State private var isSavePhoto: Bool = true
    @State private var isGoToChangeAvatar : Bool = false
    private var reminderNotification = ReminderNotification()
    @State var avatar: AvatarEntity?
    
    var body: some View {
        
        Form {
            //Section untuk User Info (Username & Avatar)
            Section {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hai, \(user.name ?? "Tidak ada nama")")
                                .foregroundColor(Color("black"))
                                .font(.lexendSemiBold(24))
                                .offset(y: -5)
                            
                            //                            Text("Ayo Bermain!")
                            //                                .foregroundColor(Color("black"))
                            //                                .font(.lexendSemiBold(18))
                            //                                .offset(y: -5)
                            
                            Button {
                                isGoToChangeAvatar.toggle()
                            } label: {
                                Text("Ubah Avatar")
                                    .foregroundColor(Color("red"))
                                    .font(.lexendMedium(16))
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(isActive: $isGoToChangeAvatar, destination: {
                                ChangeAvatarView(oldAvatar: $avatar).environment(\.managedObjectContext, viewContext)
                            }, label: {
                                EmptyView()
                            })
                            .opacity(0.0)
                            .offset(y: -5)
                            
                        }
                        
                        Image(avatar?.path ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth * 0.25, alignment: .leading)
                            .offset(x:-5, y: 7.5)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Ubah nama")
                        Spacer()
                        TextField("Masukkan nama baru...", text: $username)
                    }
                    .padding(.vertical, 10)
                }
                
            }
            //Section Setting Option
            Section {
                Toggle(isOn: $isNotificationOn, label: {
                    Text("Notifikasi")
                })
                
                if isNotificationOn {
                    HStack {
                        Text("Atur notifikasi")
                        Spacer()
                        DatePicker("Pick Your Time", selection: $currentDate, displayedComponents: [.hourAndMinute]).labelsHidden()
                    }
                    .animation(.easeInOut, value: isNotificationOn)
                }
                
                Toggle(isOn: $isSavePhoto, label: {
                    Text("Simpan foto ke galeri")
                })
                
                NavigationLink("Ubah mode pelajaran", destination: EmptyView().environment(\.managedObjectContext, viewContext))
            }
            .environment(\.horizontalSizeClass, .regular)
            .padding(.top, 10)
            .padding(.bottom, 10)
            
            //Section untuk switch profile
            Section {
                NavigationLink("Ganti profile", destination: ListProfilesView(userActive: user).environment(\.managedObjectContext, viewContext))
            }
        }
        .font(.lexendMedium())
        .backgroundImage(Asset.background)
        .onAppear{
            userRepository = UserRepository(viewContext: viewContext)
            if avatar == nil {
                avatar =  user.avatar
            }
            isSavePhoto = UserDefaults.standard.isSavePicToGallery
            isNotificationOn = user.reminder!.active
            currentDate = user.reminder?.time ?? Date()
        }
        .navigationBarItems(trailing:
                                Button(action: {
            saveData()
        }) {
            Text("Simpan").foregroundColor(.blue)
        }
        )
    }
    
    func saveData() {
        UserDefaults.standard.isSavePicToGallery = isSavePhoto
        if username == "" {
            username = user.name!
        }
        userRepository?.editUser(name: username,avatar: avatar!,  user: user)
        if isNotificationOn {
            userRepository?.turnNotification(user: user, active: isNotificationOn)
            reminderNotification.toggleNotification(entity: user.reminder! , time: currentDate, isActive: isNotificationOn)
            print("Berhasil set notif")
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    init(user: UserEntity) {
        self.user = user
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(user: UserEntity())
//    }
//}
