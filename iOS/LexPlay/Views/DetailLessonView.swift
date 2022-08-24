//
//  DetailLessonView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct DetailLessonView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var alphabets: FetchedResults<UserAlphabetEntity>
    let color: Color
    @State var startAlphabet: String = ""
    @State var endAlphabet: String = ""
    @State var progressValue: Float = 0.0
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                ZStack(alignment: .leading) {
                    Text("\(startAlphabet)-\(endAlphabet)")
                        .font(.openDyslexicBold(35))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .foregroundColor(color)
                        .card()
                    Rectangle()
                        .frame(width: min(CGFloat(progressValue), .infinity * CGFloat(progressValue)))
                        .frame(height: 70)
                        .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                }
                .cornerRadius(100)
                .padding(.leading, 20)
                
                Image("quiz")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding()
                    .frame(width: UIScreen.screenWidth / 3, height: 70)
                    .card()
                    .cornerRadius(100)
                    .padding(.trailing, 20)
            }
            
            LessonAlphabetsView(alphabets: alphabets, color: color)
                .environment(\.managedObjectContext, viewContext)
            
            Spacer()
        }
        .onAppear {
            self.startAlphabet = alphabets[0].alphabet?.char ?? ""
            self.endAlphabet = alphabets[alphabets.count - 1].alphabet?.char ?? ""
        }
        .padding(.top)
        .font(.custom(FontStyle.lexendMedium, size: 16))
        .backgroundImage(Asset.background)
    }
    
    init(user: UserEntity, lesson: LessonEntity, color: Color) {
        _alphabets = UserAlphabetRepository.getByLessonPredicate(user: user, lesson: lesson)
        self.color = color
    }
}

#if DEBUG
struct DetailLessonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLessonView(user: UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()!, lesson: (UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()?.lessons?.toArray(of: LessonEntity.self).first)!, color: Color("red"))
            .font(.custom(FontStyle.lexendRegular, size: 16))
            .foregroundColor(Color("black"))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
