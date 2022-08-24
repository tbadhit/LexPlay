//
//  CustomLessonAlphabetsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct CustomLessonAlphabetsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var alphabets: FetchedResults<UserAlphabetEntity>
    let user: UserEntity
    
    @State var isGoToAddMoreAlphabet: Bool = false

    var body: some View {
        if alphabets.count > 0 {
            TabView {
                ForEach(alphabets) { alphabet in
                    VStack {
                        UserAlphabetCardView(alphabet: alphabet, color: Color("red"), isCustomLessonView: .constant(true))
                        Spacer()
                    }
                }
                Button {
                   isGoToAddMoreAlphabet = true
                    print(userAlphabet(alphabets: alphabets))
                } label: {
                    AlphabetPlusButtonView()
                }
            }
            .background(
                NavigationLink(isActive: $isGoToAddMoreAlphabet, destination: {
                    CustomAlphabetView(user: UserModel(), userEntity: user, userAlphabets: userAlphabet(alphabets: alphabets))
                }, label: {
                    EmptyView()
                })
            )
            .frame(height: UIScreen.screenWidth + 50)
            .tabViewStyle(.page)
        } else { EmptyView() }
    }
    
    func userAlphabet(alphabets: FetchedResults<UserAlphabetEntity>) -> [String] {
        var items: [String] = []
        for char in alphabets {
            items.append(char.alphabet?.char ?? "")
        }
        
        return items
    }

    init(user: UserEntity) {
        self.user = user
        _alphabets = UserAlphabetRepository.getCustomPredicate(user: user)
    }
}

struct CustomLessonAlphabetsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLessonAlphabetsView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!)
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct AlphabetPlusButtonView: View {
    var body: some View {
        VStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .font(.lexendBold(180))
                        .foregroundColor(.brandPurple)
                    Spacer()
                }
                Spacer()
            }
            .padding(16)
            .card()
            .padding(.horizontal)
            .padding(.bottom, 48)
            Spacer()
        }
    }
}
