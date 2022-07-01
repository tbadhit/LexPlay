//
//  CameraView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 27/06/22.
//

import SwiftUI

struct CameraView: View {
  
  @StateObject var camera = CameraAlphabet()
  
  var body: some View {
    NavigationView {
      ZStack{
        // Going to Be Camera Preview...
        CameraPreview(camera: camera)
          .ignoresSafeArea(.all, edges: .all)
  //      Color.black
  //        .ignoresSafeArea(.all, edges: .all)
        
        VStack {
          
          if camera.isTaken {
            HStack {
              Spacer()
              
              Button {
                camera.reTake()
              } label: {
                Image(systemName: "arrow.triangle.2.circlepath.camera")
                  .foregroundColor(.black)
                  .padding()
                  .background(Color.white)
                  .clipShape(Circle())
              }
              .padding(.leading)
              
            }
          }
          
          Spacer()
          
          StrokeTextLabel(text: "A")
          
          Spacer()
          
          HStack {
            
            // if taken showing save and again take button ...
            
            if camera.isTaken {
              
              Button {
                if !camera.isSaved {
                  camera.savePic()
                }
              } label: {
                Text(camera.isSaved ? "Saved" : "Save")
                  .foregroundColor(.black)
                  .fontWeight(.semibold)
                  .padding(.vertical, 10)
                  .padding(.horizontal, 10)
                  .background(Color.white)
                  .clipShape(Capsule())
              }.padding(.leading)
              
              Spacer()
              
//              NavigationLink {
////                TestView()
//              } label: {
//                Text(camera.isSaved ? "Saved" : "Save")
//                  .foregroundColor(.black)
//                  .fontWeight(.semibold)
//                  .padding(.vertical, 10)
//                  .padding(.horizontal, 10)
//                  .background(Color.white)
//                  .clipShape(Capsule())
//              }

              
            } else {
              
              Button {
                camera.takePic()
              } label: {
                ZStack{
                  Circle()
                    .fill(Color.white)
                    .frame(width: 65, height: 65)
                  
                  Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 75, height: 75)
                }
              }
              
            }
            
          }.frame(height: 75)
        }
      }
      .onAppear(perform: {
        camera.check()
    })
      .navigationBarHidden(true)
    }
  }
}

struct CameraView_Previews: PreviewProvider {
  static var previews: some View {
    CameraView()
  }
}
