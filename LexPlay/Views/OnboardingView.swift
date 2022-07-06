//
//  OnboardingView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 01/07/22.
//

import SwiftUI

struct OnboardingView: View {
    @State var isNextOnboard = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("Hello,")
                        .foregroundColor(Color.black)
                        .padding(.bottom, 10)
                        .font(.lexendMedium(28))
                        .offset(x: -109, y: -105)
                    Text("Lexplay merupakan aplikasi\nmedia pembelajaran untuk\nmembantu anak disleksia\nmengenal huruf dengan\nbimbingan dari orang tua.")
                        .foregroundColor(Color.black)
                        .font(.lexendMedium(21))
                        .offset(y: -105)
                    Spacer()
                    Button {
                        withAnimation(.easeIn(duration: 1)) {
                            UserDefaults.standard.hasOnboarded = true
                            isNextOnboard.toggle()
                        }
                    } label: {
                        Text("Lanjut")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(38)
                            .font(.lexendMedium(21))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 60)

                    NavigationLink(destination: OnboardingView2().environment(\.managedObjectContext, viewContext), isActive: $isNextOnboard, label: {
                        EmptyView()
                    })
                }
                Spacer()
            }
            .background(Image("bg-onboard")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all
                ))

            .navigationBarHidden(true)
        }
    }
}

struct OnboardingView2: View {
    @Environment(\.managedObjectContext) private var viewContext

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 1)

    private let textInfoDashboard = [
        ("Multisensory", "Menciptakan\npengalaman belajar\nyang menarik dengan\nmetode multisensori\nuntuk menstimulasi\nmemori anak."),
        ("Notifikasi", "Mengingatkan orang tua\nuntuk menjaga konsistensi\npembelajaran sang anak."),
        ("Interaksi", "Membangun hubungan\ninteraktif antara anak dan\norang tua dalam proses\npembelajaran."),
        ("Personalisasi", "Komposisi huruf dapat\ndisesuaikan dengan\nkebutuhan pembelajaran\nanak."),
    ]

    @State private var currentCard = 0
    @State private var isGoToDashboardView = false

    var body: some View {
        VStack {
            ZStack {
                TabView(selection: $currentCard) {
                    ForEach(0 ..< textInfoDashboard.count, id: \.self) { i in
                        LazyVGrid(columns: columns) {
                            CardOnboard(title: textInfoDashboard[i].0, description: textInfoDashboard[i].1)
                                .tag(i)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .padding(.bottom, 100)

                VStack {
                    Spacer()
                    Image("onboard-play")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFit()
                }

                VStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            if self.currentCard == 3 {
                                isGoToDashboardView = true
                            } else {
                                self.currentCard = (self.currentCard + 1) % self.textInfoDashboard.count
                            }
                        }
                    }, label: {
                        Text("Lanjut")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(38)
                            .font(.custom(FontStyle.lexendMedium, size: 21))
                    })
                        .padding(.horizontal, 20)
                        .padding(.bottom, 60)
                }
            }
        }
        .background(Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))

        // Navigation
        NavigationLink(destination: CreateUserView(), isActive: $isGoToDashboardView, label: {
            EmptyView()
        })

            .navigationBarHidden(true)
    }
}

struct CardOnboard: View {
    let title: String
    let description: String

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(Color.black)
                    .font(.lexendMedium(28))
                    .padding(.bottom, 10)
                Text(description)
                    .foregroundColor(Color.black)
                    .font(.custom(FontStyle.lexendMedium, size: 21))
            }
            .padding(30)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.screenWidth)
            .card()
            .cardPadding()
            .padding(.bottom, 105)

            Image("star")
                .resizable()
                .frame(width: 108, height: 125)
                .offset(x: 100, y: -175)
        }
    }
}

// struct OnboardingView_Previews: PreviewProvider {
//  static var previews: some View {
//    OnboardingView2()
//  }
// }
