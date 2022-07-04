//
//  LetterCaseView.swift
//  LexPlay
//
//  Created by erlina ng on 03/07/22.
//

import SwiftUI

struct LetterCaseView: View {
    @State var buttonTap : Bool = false
    @State var isLinkActive : Bool = false
    @State var idx : Int = 0
    //@State private var cardTap : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .edgesIgnoringSafeArea(.top)
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 38, style: .continuous)
                            .fill(.white)
                            .padding()
                        HStack {
                            Image("play")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .mask(Rectangle().padding(.bottom, 25))
                                .frame(width: UIScreen.screenWidth * 0.29, alignment: .leading)
                                .offset(x: 3, y: 14)
                                
                            Text("Pilih jenis huruf yang ingin dipelajari")
                                .foregroundColor(Color("black"))
                                .font(.custom(FontStyle.lexendMedium, size: 17))
                                .fontWeight(.semibold)
                                .frame(width: UIScreen.screenWidth * 0.5, alignment: .leading)
                            
                        }
                        Spacer()
                    }
                    .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.16, alignment: .leading)
                    
                    HStack(alignment: .center) {
                        LetterCard(letterCase: "Huruf Kapital", letterString: "AA", id: 1, idx: idx)
                            
                            .onTapGesture {
                                idx = 1
                                buttonTap = true
                            }
                        
                        LetterCard(letterCase: "Huruf Kecil", letterString: "aa", id: 2, idx: idx)
                            .onTapGesture {
                                idx = 2
                                buttonTap = true
                            }
                    }
                    .frame(width: UIScreen.screenWidth, alignment: .center)
                    .padding(.leading , 13)
                    
                    
                    HStack(alignment: .center)  {
                        LetterCard(letterCase: "Keduanya", letterString: "Aa", id: 3, idx: idx)
                            .onTapGesture {
                                idx = 3
                                buttonTap = true
                            }
                    }
                    .frame(width: UIScreen.screenWidth, alignment: .center)
                    .padding(.leading , 13)

                    
                    //Nav Link (Ganti ke view lain)
                    ZStack{
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color("gradient1"), lineWidth: 9)
                            .frame(width: UIScreen.screenWidth * 0.9,height: UIScreen.screenHeight * 0.07, alignment: .center)
                    
                        NavigationLink("Change Lesson Mode", destination: CameraResultUI())
                                .font(.custom(FontStyle.lexendMedium, size: 21))
                                .opacity(1)
                                .frame(width: UIScreen.screenWidth * 0.9,height: UIScreen.screenHeight * 0.07, alignment: .center)
                                .foregroundColor(buttonTap ? Color.white : Color("gradient1"))
                                .background(buttonTap ? LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .bottomTrailing, endPoint: .topLeading) : LinearGradient(colors: [Color.white, Color.white], startPoint: .bottomTrailing, endPoint: .topLeading))
                                .cornerRadius(25)
                    }
                    .padding(.top , UIScreen.screenHeight * 0.1)
                    .offset(x: -3)

                }
                .frame(minWidth : 0, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity, alignment: .topLeading)
            }
            
        }.navigationBarHidden(true)
    }
}

struct LetterCard: View {
    let letterCase : String
    let letterString : String
    let id : Int
    var idx : Int

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 38, style: .continuous)
                .fill(id == idx ? LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .bottomTrailing, endPoint: .topLeading) : LinearGradient(colors: [Color.white, Color.white], startPoint: .bottomTrailing, endPoint: .topLeading))
                .frame(width: UIScreen.screenWidth * 0.43, height: UIScreen.screenHeight * 0.2, alignment: .center)
            
            VStack {
                Text("\(letterString)")
                    .foregroundColor(id == idx ? Color.white : Color("black"))
                    .font(.custom(FontStyle.lexendMedium, size: 72))
                    .fontWeight(.semibold)
                    .offset(y:-10)
                
                Text("\(letterCase)")
                    .foregroundColor(id == idx ? Color.white : Color("black"))
                    .font(.custom(FontStyle.lexendMedium, size: 17))
                    .fontWeight(.semibold)
                    .offset(y:-10)
            }
        }
        .frame(width: UIScreen.screenWidth * 0.5, height: UIScreen.screenHeight * 0.22, alignment: .leading)
    }
}

struct LetterCaseView_Previews: PreviewProvider {
    static var previews: some View {
        LetterCaseView()
    }
}

