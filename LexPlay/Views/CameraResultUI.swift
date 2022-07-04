//
//  CameraResultUI.swift
//  LexPlay
//
//  Created by erlina ng on 04/07/22.
//

import SwiftUI

struct CameraResultUI: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack(spacing: 30) {
                    
                    ZStack() {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.white)
                            .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.45)
                            
                        Image("example")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth * 0.6, height: UIScreen.screenHeight * 0.5)
                    }
     
                    HStack (spacing: 35){
                        ZStack{
                            NavigationLink("Save", destination: Text("YEY"))
                                    .font(.custom(FontStyle.lexendMedium, size: 21))
                                    .frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.08)
                                    .background(LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .bottomTrailing, endPoint: .topLeading))
                                    .cornerRadius(38)
                                    .foregroundColor(.white)
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 38, style: .continuous)
                                .stroke(Color("gradient1"), lineWidth: 6)
                                .frame(width: UIScreen.screenWidth * 0.4,height: UIScreen.screenHeight * 0.08, alignment: .center)
                        
                            NavigationLink("Retake", destination: CameraView())
                                    .font(.custom(FontStyle.lexendMedium, size: 21))
                                    .opacity(1)
                                    .frame(width: UIScreen.screenWidth * 0.398,height: UIScreen.screenHeight * 0.08, alignment: .center)
                                    .foregroundColor( Color("gradient1"))
                                    .background(.white)
                                    .cornerRadius(38)
                        }

                    }
                }
            }
            .frame(minWidth : 0, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity, alignment: .top)
            .background(LinearGradient(colors: [Color("Color"), Color("Color"), Color.white], startPoint: .bottomLeading, endPoint: .topTrailing))
            .navigationBarHidden(true)
        }
        
    }
}

struct CameraResultUI_Previews: PreviewProvider {
    static var previews: some View {
        CameraResultUI()
    }
}
