//
//  UserAlphabetCardView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct UserAlphabetCardView: View {
    @ObservedObject var alphabet: UserAlphabetEntity
    @ObservedObject var guideViewModel = GuideViewModel.shared
    let color: Color

    @State private var popInfo = false
    @State var frontDegree = 0.0
    @State var backDegree = -90.0
    @State var isFlipped = false
    
    @Binding var isCustomLessonView: Bool

    let width: CGFloat = UIScreen.screenWidth
    let height: CGFloat = UIScreen.screenHeight
    let durationAndDelay: CGFloat = 0.3

    func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
            }
        }
    }

    func changeCardDirection(to: Bool) {
        if to != isFlipped {
            flipCard()
        }
    }

    var body: some View {
        ZStack {
            AlphabetCardFront(width: width, height: height, alphabet: alphabet, degree: $frontDegree, isFlipped: $isFlipped, isCustomLessonView: $isCustomLessonView, color: color)
            AlphabetCardBack(width: width, height: height, userAlphabet: alphabet, degree: $backDegree, isFlipped: $isFlipped)
        }.onTapGesture {
            flipCard()
        }
        .highlighted(tag: .alphabetCard__Flip, highlightedComponent: guideViewModel.guidedComponent, animationPhase: guideViewModel.phase)
        .onChange(of: guideViewModel.guidedComponent) { newValue in
            guard let newValue = newValue else { return }
            switch newValue {
            case .alphabetCard__Mic:
                changeCardDirection(to: false)
            case .alphabetCard:
                changeCardDirection(to: false)
            case .alphabetCard__Alphabet:
                changeCardDirection(to: false)
            case .alphabetCard__Speaker:
                changeCardDirection(to: false)
            case .alphabetCard__Flip:
                changeCardDirection(to: !isFlipped)
            case .alphabetCard__Camera:
                changeCardDirection(to: true)
            default:
                break
            }
        }
    }
}

fileprivate struct AlphabetCardFront: View {
    private let audioService: AudioService = AudioService.shared
    @ObservedObject var guideViewModel = GuideViewModel.shared
    @StateObject private var speechRecognizer = SpeechRecognizer.shared
    @State private var showRecognizingResult = false

    let width: CGFloat
    let height: CGFloat
    let alphabet: UserAlphabetEntity
    @Binding var degree: Double
    @Binding var isFlipped: Bool
    @Binding var isCustomLessonView: Bool
    @State var popInfo: Bool = false
    let color: Color

    var body: some View {
        VStack {
            if isCustomLessonView {
                HStack {
                    Spacer()
                    Image("quiz")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .overlay(Circle().stroke(Color("red"), lineWidth: 4))
                }
            }
            Spacer()
            Text(alphabet.alphabet?.char ?? "")
                .font(.openDyslexicBold(100))
                .foregroundColor(color)
                .highlighted(tag: .alphabetCard__Alphabet, highlightedComponent: guideViewModel.guidedComponent, animationPhase: guideViewModel.phase)
            Spacer()
            HStack {
                Button {
                    audioService.speak(alphabet: alphabet.alphabet)
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 70)
                        .background(Color("blue"))
                }
                .cornerRadius(38)
                .highlighted(tag: .alphabetCard__Speaker, highlightedComponent: guideViewModel.guidedComponent, animationPhase: guideViewModel.phase)
            }
            .font(.largeTitle)
            .foregroundColor(.brandPurple)
        }
        .padding(16)
        .card()
        .opacity(isFlipped ? 0.5 : 1)
        .animation(.easeInOut(duration: 0.5), value: isFlipped)
        .padding(.horizontal)
        .padding(.bottom, 48)
        .rotation3DEffect(.init(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }

    private func getResult() -> Bool {
        guard let char = alphabet.alphabet?.char?.lowercased() else { return false }
        guard let alphabet = Alphabet(rawValue: char) else { return false }
        return speechRecognizer.isCorrect(alphabet: alphabet)
    }

    func getAlertTitle(isProcessing: Bool) -> Text {
        guard !isProcessing else {
            return Text("Tunggu...")
        }
        return getResult() ? Text("Benar!") : Text("Coba Lagi")
    }

    func getAlertMessage(isProcessing: Bool) -> Text {
        guard !isProcessing else {
            return Text("Sedang mengenali")
        }
        let feedbackGenerator = UINotificationFeedbackGenerator()
        if getResult() {
            feedbackGenerator.notificationOccurred(.success)
            return Text("🥳")
        }
        feedbackGenerator.notificationOccurred(.error)
        return Text("🤔")
    }
}

fileprivate struct AlphabetCardBack: View {
    let width: CGFloat
    let height: CGFloat
    @ObservedObject var guideViewModel = GuideViewModel.shared
    @ObservedObject var userAlphabet: UserAlphabetEntity
    @Binding var degree: Double
    @Binding var isFlipped: Bool
    @State var popInfo: Bool = false
    @State var isGoToCameraView: Bool = false

    var body: some View {
        VStack {
            Spacer()
            VStack {
                if let img = userAlphabet.imageAssociation, let uiImage = UIImage(data: img) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    

                } else {
                    Text("Tidak ada gambar")
                        .font(.lexendMedium(32))
                }
            }
            .padding(.vertical, 12)
            Spacer()
            Button(action: {
                self.isGoToCameraView = true
            }, label: {
                Image(systemName: "camera.fill")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .background(Color("blue"))
            })
            .cornerRadius(38)
            .font(.largeTitle)
            .foregroundColor(.brandPurple)
            .highlighted(tag: .alphabetCard__Camera, highlightedComponent: guideViewModel.guidedComponent, animationPhase: guideViewModel.phase)
        }
        .background(
            NavigationLink(isActive: $isGoToCameraView, destination: {
                CameraView(alphabet: userAlphabet.alphabet?.char ?? "", userAlphabet: userAlphabet)
            }, label: {
                EmptyView()
            }).hidden()
        )
        .padding(16)
        .card()
        .opacity(isFlipped ? 1 : 0.5)
        .animation(.easeInOut(duration: 0.5), value: isFlipped)
        .padding(.horizontal)
        .padding(.bottom, 48)
        .rotation3DEffect(.init(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct UserAlphabetView_Previews: PreviewProvider {
    static var previews: some View {
        UserAlphabetCardView(alphabet: (UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()?.alphabets?.toArray(of: UserAlphabetEntity.self).first)!, color: .red, isCustomLessonView: .constant(false))
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .backgroundImage(Asset.background)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
