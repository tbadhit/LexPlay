//
//  LessonsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

struct LessonsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.view) private var lessonView
    @FetchRequest private var lessons: FetchedResults<LessonEntity>
    @ObservedObject private var user: UserEntity
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
    private let images: [(String, CGFloat, CGFloat, CGFloat)] = [
        ("bluey", CGFloat(100), CGFloat(-16), CGFloat(-16)),
        ("orangey", CGFloat(171), CGFloat(-32), CGFloat(-70)),
        ("limey", CGFloat(125), CGFloat(-80), CGFloat(-30)),
        ("cyany", CGFloat(125), CGFloat(-32), CGFloat(-32)),
        ("er", CGFloat(261), CGFloat(-20), CGFloat(-16)),
    ]
    
    var body: some View {
            VStack {
                MiniProfileView(user: user)
                    .padding(.top, 32)
                    .padding(.bottom, 8)
                    .padding(.horizontal)
                MiniReminderView(user: user)
                    .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text("Pelajaran")
                        .font(.custom(FontStyle.lexendSemiBold, size: 24))
                        .padding(.horizontal)
                        .padding(.top, 8)
                    TabView {
                        VStack {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(0 ..< (lessons.count > 4 ? 4 : lessons.count), id: \.self) { i in
                                    getNavLink(i: i)
                                }
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        
                        if lessons.count > 4 {
                            getNavLink(i: 4)
                                .padding(.horizontal)
                        }
                    }
                    .frame(height: UIScreen.screenWidth)
                    .tabViewStyle(.page)
                }
                Spacer()
            }
            .onAppear(perform: {
                lessonView.wrappedValue = 5
            })
            .font(.lexendMedium(16))
            .backgroundImage(Asset.background)
            .scrollOnOverflow()
            .navigationBarHidden(true)
        
    }
    
    func getNavLink(i: Int) -> some View {
        return NavigationLink(destination: DetailLessonView(user: user, lesson: lessons[i])
            .navigationBarTitle("", displayMode: .inline)) {
                LessonItemView(i: i, image: images[i])
            }
    }
    
    init(user: UserEntity) {
        self.user = user
        _lessons = LessonRepository.getPredicate(user: user)
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LessonsView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
        .previewInterfaceOrientation(.portrait)
    }
}

struct LessonItemView: View {
    let i: Int
    let image: (String, CGFloat, CGFloat, CGFloat)
    
    var body: some View {
        VStack {
            HStack {
                Image(image.0)
                    .resizable()
                    .scaledToFit()
                    .frame(width: image.1)
                    .padding(.bottom, image.2)
                    .padding(.leading, image.3)
                Spacer()
                Text(String(i + 1))
                    .font(.lexendSemiBold(64))
                    .foregroundColor(Color("black"))
            }
            .padding(.trailing, 16)
            .padding(.top, 16)
            .frame(height: UIScreen.screenWidth / 2.5)
            .card()
            Spacer()
        }
    }
}
