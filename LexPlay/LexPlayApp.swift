//
//  LexPlayApp.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 25/06/22.
//

import SwiftUI

@main
struct LexPlayApp: App {
    let persistenceController = PersistenceController.shared
    @State private var userRepository: UserRepository = UserRepository()
    @State private var alphabetService: AlphabetService = AlphabetService()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                //            Change the view
                //            ContentView()
                //                          CameraView()
                //         AlphabetRecognitionView()
                //           LetterCaseView()
                //          UsersView()
                if UserDefaults.standard.hasOnboarded {
                    NavigationLink(isActive: .constant(true)) {
                        if userRepository.getActiveUser()!.isLearnCustomLesson {
                            CustomLessonsView(user: userRepository.getActiveUser()!)
                        } else {
                            LessonsView(user: userRepository.getActiveUser()!)
                                .onAppear {
                                    
//                                    UserAlphabetRepository.getCustomPredicate(user: userRepository.getActiveUser())
                                    print(UserAlphabetRepository.getCustomPredicate(user: userRepository.getActiveUser()!))
                                }
                        }
                        
                    } label: {
                        EmptyView()
                    }

                } else {
                    OnboardingView()
                        .navigationBarHidden(true)
                }
                //                            OnboardingView()
                //                LessonsView(user: UserRepository(viewContext: persistenceController.container.viewContext).getActiveUser()!)
                //            CustomAlphabetView()
                //            CustomLessonsView()
                //          }
                //            }
                //                OnboardingView()
            }
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
