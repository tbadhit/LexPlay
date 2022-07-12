//
//  LetterCaseView.swift
//  LexPlay
//
//  Created by erlina ng on 03/07/22.
//

import SwiftUI

struct LetterCaseView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var user: UserModel
    
    @State private var userRepository: UserRepository? = nil
    @State private var userAlphabetRepository: UserAlphabetRepository? = nil
    @State var userEntity: UserEntity? = nil
    @State var buttonTap : Bool = false
    @State var isLinkActive : Bool = false
    @State var idx : Int = 0
    
    @State var isGoToLessonView = false
    @State var isGoToCustomLessonView = false
    
    var body: some View {
        HStack {
            Spacer()
            VStack{
                CardSays(imageName: "play", information: "Pilih jenis huruf yang\ningin dipelajari")
                    .padding(.bottom, 20)
                
                
                HStack {
                    LetterCard(letterCase: "Huruf Kapital", letterString: "AA", id: 1, idx: idx)
                    
                        .onTapGesture {
                            idx = 1
                            buttonTap = true
                        }
                    
                    Spacer()
                    
                    LetterCard(letterCase: "Huruf Kecil", letterString: "aa", id: 2, idx: idx)
                        .onTapGesture {
                            idx = 2
                            buttonTap = true
                        }
                }
                .padding(.bottom, 20)
                
                
                HStack  {
                    LetterCard(letterCase: "Keduanya", letterString: "Aa", id: 3, idx: idx)
                        .onTapGesture {
                            idx = 3
                            buttonTap = true
                        }
                }
                .padding(.bottom, 70)
                
                
                //Nav Link (Ganti ke view lain)
                Button {
                    UserDefaults.standard.hasOnboarded = true
                    var letterCase: LetterCase = .upper
                    switch idx {
                    case 1:
                        letterCase = .upper
                    case 2:
                        letterCase = .lower
                    default:
                        letterCase = .both
                    }
                    user.letterCase = letterCase
                    userRepository?.addUser(user: user)
                    userEntity = userRepository?.getActiveUser()
                    
                    guard let userEntity = userEntity else {
                        print("ERROR: Cannot save alphabets")
                        return
                    }
                    userAlphabetRepository?.saveAlphabetsToUser(user: userEntity, alphabets: user.alphabets, letterCase: letterCase)
                    
                    if user.isLearnCustomLesson {
                        isGoToCustomLessonView.toggle()
                    } else {
                        isGoToLessonView.toggle()
                    }
                } label: {
                    Text("Selesai")
                        .font(.custom(FontStyle.lexendMedium, size: 21))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 75)
                }
                .background(buttonTap ? Color.buttonAndSelectedtColor : LinearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(38)
                .disabled(!buttonTap)
                
                
                
                if let userEntity = userEntity {
                    NavigationLink(isActive: user.isLearnCustomLesson ? $isGoToCustomLessonView : $isGoToLessonView) {
                        if user.isLearnCustomLesson {
                            NavigationLazyView(CustomLessonsView(user: userEntity))
                        } else {
                            NavigationLazyView(LessonsView(user: userEntity))
                        }
                    } label: {
                        EmptyView()
                    }
                }
                Spacer()
                
            }
                .padding(.horizontal, 20)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
        .onAppear {
            userRepository = UserRepository(viewContext: viewContext)
            userAlphabetRepository = UserAlphabetRepository(viewContext: viewContext)
        }
    }
}

struct LetterCard: View {
    let letterCase : String
    let letterString : String
    let id : Int
    var idx : Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 38, style: .continuous)
                .fill(id == idx ? LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .bottomTrailing, endPoint: .topLeading) : LinearGradient(colors: [Color.white, Color.white], startPoint: .bottomTrailing, endPoint: .topLeading))
                .frame(width: UIScreen.screenWidth * 0.43, height: UIScreen.screenHeight * 0.2, alignment: .center)
            
            VStack {
                Text("\(letterString)")
                    .foregroundColor(id == idx ? Color.white : Color("black"))
                    .font(.custom(FontStyle.lexendMedium, size: 72))
                    .fontWeight(.semibold)
                    .offset(y:-10)
                
                Text("\(letterCase)")
                    .foregroundColor(id == idx ? Color.white : Color("black"))
                    .font(.custom(FontStyle.lexendMedium, size: 17))
                    .fontWeight(.semibold)
                    .offset(y:-10)
            }
        }
    }
}

struct LetterCaseView_Previews: PreviewProvider {
    static var previews: some View {
        LetterCaseView(user: UserModel())
    }
}
