//
//  CameraPreview.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 27/06/22.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
  
  @ObservedObject var camera: CameraModel
  
  func makeUIView(context: Context) -> some UIView {
    let view = UIView(frame: UIScreen.main.bounds)
    
    camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
    camera.preview.frame = view.frame
    
    // Your own properties...
    camera.preview.videoGravity = .resizeAspectFill
    view.layer.addSublayer(camera.preview)
    
    // starting session
    camera.session.startRunning()
    
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    
  }
}
