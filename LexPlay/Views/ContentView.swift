//
//  ContentView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 14/07/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var activeUsers: FetchedResults<UserEntity>

    var body: some View {
        NavigationView {
            //            Change the view
            //            ContentView()
            //                          CameraView()
            //         AlphabetRecognitionView()
            //           LetterCaseView()
            //          UsersView()
            if UserDefaults.standard.hasOnboarded, let user = activeUsers.first {
                NavigationLink(isActive: .constant(true)) {
                    if user.isLearnCustomLesson {
                        CustomLessonsView(user: user)
                    } else {
                        LessonsView(user: user)
                            .onAppear {
//                                    UserAlphabetRepository.getCustomPredicate(user: userRepository.getActiveUser())
                                print(UserAlphabetRepository.getCustomPredicate(user: user))
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
    }

    init() {
        _activeUsers = UserRepository.getActiveUserPredicate()
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
