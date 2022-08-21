//
//  UserAlphabetCardView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct UserAlphabetCardView: View {
    @ObservedObject var alphabet: UserAlphabetEntity

    @State private var popInfo = false
    @State var frontDegree = 0.0
    @State var backDegree = -90.0
    @State var isFlipped = false

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

    var body: some View {
        ZStack {
            AlphabetCardFront(width: width, height: height, alphabet: alphabet, degree: $frontDegree, isFlipped: $isFlipped)
            AlphabetCardBack(width: width, height: height, userAlphabet: alphabet, degree: $backDegree, isFlipped: $isFlipped)
        }.onTapGesture {
            flipCard()
        }
    }
}

fileprivate struct AlphabetCardFront: View {
    private let audioController: AudioService = AudioService.shared
    @StateObject private var speechRecognizer = SpeechRecognizer.shared
    @State private var showRecognizingResult = false

    let width: CGFloat
    let height: CGFloat
    let alphabet: UserAlphabetEntity
    @Binding var degree: Double
    @Binding var isFlipped: Bool
    @State var popInfo: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    popInfo.toggle()
                } label: { Image(systemName: "info.circle.fill")
                    .font(.title)
                    .foregroundColor(.brandPurple)
                }
                .popover(isPresented: $popInfo) {
                    HowToPlayView()
                }
            }
            .alert(isPresented: $speechRecognizer.isError) {
                Alert(title: Text("Mic Error"),
                      message: Text("Mic tidak terdeteksi. Tidak dapat menggunakan fitur bicara."),
                      dismissButton: .default(Text("Mengerti")))
            }
            Spacer()
            Text(alphabet.alphabet?.char ?? "")
                .font(.custom(FontStyle.lexendBold, size: 180))
            Spacer()
            HStack {
                Button {
                    audioController.speak(alphabet: alphabet.alphabet)
                } label: { Image(systemName: "speaker.wave.2.fill") }
                Button {} label: { Image(systemName: "mic.fill") }
                    .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                        if pressing {
                            showRecognizingResult = false
                            speechRecognizer.transcribe()
                        } else {
                            showRecognizingResult = true
                            speechRecognizer.stopTranscribing()
                            if !speechRecognizer.isProcessing {
                                speechRecognizer.cancelAndReset()
                            }
                        }
                    }, perform: {})
                    .alert(isPresented: $showRecognizingResult) {
                        let isProcessing = speechRecognizer.isProcessing || speechRecognizer.isRecording
                        return Alert(title: getAlertTitle(isProcessing: isProcessing),
                                     message: getAlertMessage(isProcessing: isProcessing),
                                     dismissButton: .default(Text(isProcessing ? "Batalkan" : "Oke"), action: { speechRecognizer.cancelAndReset() }))
                    }
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
    @ObservedObject var userAlphabet: UserAlphabetEntity
    @Binding var degree: Double
    @Binding var isFlipped: Bool
    @State var popInfo: Bool = false
    @State var isGoToCameraView: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    popInfo.toggle()
                } label: { Image(systemName: "info.circle.fill")
                    .font(.title)
                    .foregroundColor(.brandPurple)
                }
                .popover(isPresented: $popInfo) {
                    HowToPlayView()
                }
            }
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
                    .font(.title)
            })
            .font(.largeTitle)
            .foregroundColor(.brandPurple)
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
        UserAlphabetCardView(alphabet: (UserRepository(viewContext: PersistenceController.preview.container.viewContext).getActiveUser()?.alphabets?.toArray(of: UserAlphabetEntity.self).first)!)
            .font(.lexendRegular())
            .foregroundColor(.brandBlack)
            .backgroundImage(Asset.background)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
