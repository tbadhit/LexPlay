//
//  CameraView.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 27/06/22.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var camera = CameraAlphabet()
    let alphabet: String
    let userAlphabet: UserAlphabetEntity

    var body: some View {
            ZStack {
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
                                HStack {
                                    Text("Foto ulang")
                                        .foregroundColor(.black)
                                        .font(.lexendSemiBold())
                                        
                                    Image(systemName: "arrow.triangle.2.circlepath.camera")
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(.white)
                                .clipShape(Capsule())
                                
                            }
                            .padding(.trailing, 15)
                        }
                    } else {
                        HStack {
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("< Kembali")
                                    .foregroundColor(.black)
                                    .font(.lexendSemiBold())
                                    .padding()
                                    .background(.white)
                                    .clipShape(Capsule())
                            }
                            .padding(.leading)
                            
                            Spacer()
                        }
                    }

                    Spacer()

                    StrokeTextLabel(text: alphabet)
                        .padding(.bottom,90)

                    Spacer()

                    HStack {
                        // if taken showing save and again take button ...

                        if camera.isTaken {
                            Button {
                                if !camera.isSaved {
                                    camera.savePic(userAlphabet: userAlphabet)
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            } label: {
                                Text(camera.isSaved ? "Saved" : "Simpan gambar")
                                    .foregroundColor(.black)
                                    .font(.lexendSemiBold())
                                    .padding()
                                    .background(.white)
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
                                print("Gambar diambil")
                            } label: {
                                ZStack {
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

//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView(alphabet: "a", )
//    }
//}
