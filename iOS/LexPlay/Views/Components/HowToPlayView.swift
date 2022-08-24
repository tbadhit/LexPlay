//
//  HowToPlayView.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

struct HowToPlayView: View {
    private let audioService = AudioService.shared

    var body: some View {
        VStack {
            Text("Cara Bermain")
                .font(.lexendBold(32))
                .fontWeight(.medium)
                .padding(.bottom, 8)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "a.square")
                    Text("Lihat dan amati huruf")
                }
                HStack {
                    Image(systemName: "speaker.wave.2.fill")
                    Text("Dengar suara huruf")
                }
                HStack {
                    Image(systemName: "mic.fill")
                    Text("Tahan dan ikuti suara huruf")
                }
                HStack {
                    Image(systemName: "rectangle.2.swap")
                    Text("Sentuh kartu")
                }
                HStack {
                    Image(systemName: "camera.fill")
                    Text("Foto kumpulan benda yang menyerupai bentuk huruf  ")
                }
            }
            HStack {
                Spacer()
                Button {
                    if audioService.isSpeaking() {
                        audioService.stopSpeaking()
                    } else {
                        audioService.speak(name: AudioName.howToPlay.rawValue)
                    }
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundColor(.brandPurple)
                }
            }
            .padding(.top)
        }
        .font(.lexendMedium(22))
        .padding()
//        .card()
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
            .font(.custom(FontStyle.lexendRegular, size: 16))
            .foregroundColor(Color("black"))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
