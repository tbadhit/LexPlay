//
//  ContentView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 14/07/22.
//

import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .lesson
    
    enum Page {
        case onboarding1
        case onboarding2
        case createUser
        case specificLetter
        case customAlphabet
        case letterCase
        case lesson
        case customLesson
        case detailLesson
        case quiz
    }
}


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewRouter = ViewRouter()
    @FetchRequest private var activeUsers: FetchedResults<UserEntity>
    @State private var mainView = 2
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if UserDefaults.standard.hasOnboarded, let user = activeUsers.first {
                        MainView(user: user)
                    } else {
                        OnboardingView()
                    }
                }
                .navigationBarHidden(true)
            }
            FloatingView()

        }
        .environmentObject(viewRouter)
        
    }
    
    init() {
        _activeUsers = UserRepository.getActiveUserPredicate()
    }
}

struct FloatingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var currentPosition: CGSize = CGSize(width: 150, height: UIScreen.screenHeight / 2 - 72)
    @State private var newPosition: CGSize = CGSize(width: 150, height: UIScreen.screenHeight / 2 - 72)
    
    var body: some View {
        
        Image("play")
            .resizable()
            .frame(width: UIScreen.screenWidth / 6 - 2.5, height: UIScreen.screenWidth / 5 - 5)
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
            .onTapGesture(perform: {
                
//                debugPrint("Action")
                print("Page saat ini :\(viewRouter.currentPage)")
            })
            .gesture(DragGesture()
                .onChanged { value in
                    print("onCHange width : \(value.translation.width + self.newPosition.width)")
                    print("onChange height : \(value.translation.height + self.newPosition.height)")
                    withAnimation(.easeIn(duration: 0.1)) {
                        self.currentPosition = CGSize(
                            width: value.translation.width + self.newPosition.width,
                            height: value.translation.height + self.newPosition.height
                        )
                    }
                    
                }
                .onEnded { value in
                    withAnimation(.easeOut(duration: 0.35)) {
                        let width = value.translation.width + self.newPosition.width
                        let heightSafeArea = UIScreen.screenHeight / 2 - 72
                        let widthSafeArea = UIScreen.screenWidth / 2 - 35
                        print(UIScreen.screenWidth / 5 - 5)
                        if currentPosition.width < 0.0 {
                            print("Negativ jalan")
                            if currentPosition.height > heightSafeArea {
                                self.currentPosition = CGSize(
                                    width: width < -widthSafeArea ? -widthSafeArea : width,
                                    height: heightSafeArea
                                )
                            } else if currentPosition.height < -heightSafeArea  {
                                self.currentPosition = CGSize(
                                    width: width < -widthSafeArea ? -widthSafeArea : width,
                                    height: -heightSafeArea
                                )
                            }else {
                                self.currentPosition = CGSize(
                                    width:  -UIScreen.screenWidth / 2 - -35,
                                    height: value.translation.height + self.newPosition.height
                                )
                            }
                        } else {
                            print("positif jalan")
                            print("350 = \(heightSafeArea)")
                            print("160 = \(widthSafeArea)")
                            if currentPosition.height > heightSafeArea {
                                self.currentPosition = CGSize(
                                    width: width > widthSafeArea ? widthSafeArea : width,
                                    height: heightSafeArea
                                )
                            } else if currentPosition.height < -heightSafeArea {
                                self.currentPosition = CGSize(
                                    width: width > widthSafeArea ? widthSafeArea : width,
                                    height: -heightSafeArea)
                            } else {
                                self.currentPosition = CGSize(
                                    width:  UIScreen.screenWidth / 2 - 35,
                                    height: value.translation.height + self.newPosition.height
                                )
                            }
                            
                        }
                        self.newPosition = self.currentPosition
                    }
                }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
