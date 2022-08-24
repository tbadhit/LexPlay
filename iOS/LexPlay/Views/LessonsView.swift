//
//  LessonsView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

struct LessonsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var lessons: FetchedResults<LessonEntity>
    @ObservedObject private var user: UserEntity
    @ObservedObject var guideViewModel = GuideViewModel.shared

    private let images: [(String, CGFloat, CGFloat, CGFloat)] = [
        ("bluey", CGFloat(95), CGFloat(-80), CGFloat(47)),
        ("orangey", CGFloat(171), CGFloat(-32), CGFloat(-10)),
        ("limey", CGFloat(125), CGFloat(-60), CGFloat(21)),
        ("cyany", CGFloat(125), CGFloat(-80), CGFloat(26)),
        ("er", CGFloat(227), CGFloat(-20), CGFloat(-70)),
    ]

    var body: some View {
        VStack {
            MiniProfileView(user: user)
                .padding(.top, 32)
                .padding(.bottom, 8)
                .padding(.horizontal)
//                MiniReminderView(user: user)
//                    .padding(.horizontal)
            VStack(alignment: .leading) {
                Text("Pelajaran")
                    .font(.custom(FontStyle.lexendSemiBold, size: 24))
                    .padding(.horizontal)
                    .padding(.leading, 10)
                    .padding(.top, 8)
                ForEach(0 ..< lessons.count, id: \.self) { i in
                    if i < images.count {
                        getNavLink(i: i)
                    }
                }.padding(.horizontal)
            }
            Spacer()
        }
        .font(.lexendMedium(16))
        .scrollOnOverflow()
        .backgroundImage(Asset.background)
        .navigationBarHidden(true)
        .onDidAppear {
            guideViewModel.guidingAudios = [.lesson__List]
        }
        .onWillDisappear {
            guideViewModel.stopAndReset()
        }
    }

    func getNavLink(i: Int) -> some View {
        return NavigationLink { DetailLessonView(user: user, lesson: lessons[i], color: Color.generateFrom(data: images[i].0))
            .navigationBarTitle("", displayMode: .inline)
        } label: {
            LessonItemView(user: user, lesson: lessons[i], image: images[i]).padding(.bottom, 3)
                .highlighted(tag: .lesson__List, highlightedComponent: guideViewModel.guidedComponent, animationPhase: guideViewModel.phase)
        }
    }

    init(user: UserEntity) {
        self.user = user
        _lessons = LessonRepository.getPredicate(user: user)
    }
}

extension Color {
    static func generateFrom(data: String) -> Self {
        var colorName = ""
        switch data {
        case "bluey":
            colorName = "blue"
        case "orangey":
            colorName = "orangeyColor"
        case "limey":
            colorName = "limeyColor"
        case "cyany":
            colorName = "cyanyColor"
        case "er":
            colorName = "softPurple"
        default:
            colorName = "black"
        }
        return Color(colorName)
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
    @FetchRequest private var alphabets: FetchedResults<UserAlphabetEntity>

    let image: (String, CGFloat, CGFloat, CGFloat)
    @State var startAlphabet: String = ""
    @State var endAlphabet: String = ""

    var body: some View {
        VStack {
            HStack {
                Image(image.0)
                    .resizable()
                    .scaledToFit()
                    .frame(width: image.1, height: 206)
                    .padding(.bottom, image.2)
                    .padding(.leading, image.3)
                Spacer()
                Text("\(startAlphabet)-\(endAlphabet)")
                    .font(.openDyslexicBold(60))
                    .foregroundColor(Color.generateFrom(data: image.0))
                Spacer()
            }
            .padding(.trailing, 16)
            .padding(.top, 16)
            .frame(height: UIScreen.screenWidth / 2.5 - 6)
            .card()
            .cornerRadius(45)
            Spacer()
        }
        .onAppear {
            self.startAlphabet = alphabets[0].alphabet?.char ?? ""
            self.endAlphabet = alphabets[alphabets.count - 1].alphabet?.char ?? ""
        }
    }

    init(user: UserEntity, lesson: LessonEntity, image: (String, CGFloat, CGFloat, CGFloat)) {
        _alphabets = UserAlphabetRepository.getByLessonPredicate(user: user, lesson: lesson)
        self.image = image
    }
}
