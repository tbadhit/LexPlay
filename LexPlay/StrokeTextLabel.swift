//
//  StrokeTextLabel.swift
//  CameraOverlay
//
//  Created by Tubagus Adhitya Permana on 29/06/22.
//

import SwiftUI

struct StrokeTextLabel: UIViewRepresentable {
  
  let text: String
  
  func makeUIView(context: Context) -> UILabel {
    let attributedStringParagraphStyle = NSMutableParagraphStyle()
    attributedStringParagraphStyle.alignment = NSTextAlignment.center
    let attributedString = NSAttributedString(
      string: text,
      attributes:[
        NSAttributedString.Key.paragraphStyle: attributedStringParagraphStyle,
        NSAttributedString.Key.strokeWidth: 2.0,
        NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.strokeColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name:"Helvetica", size:400.0)!
      ]
    )
    
    let strokeLabel = UILabel(frame: CGRect.zero)
    strokeLabel.attributedText = attributedString
    strokeLabel.backgroundColor = UIColor.clear
    strokeLabel.sizeToFit()
    strokeLabel.center = CGPoint.init(x: 0.0, y: 0.0)
    return strokeLabel
  }
  
  func updateUIView(_ uiView: UILabel, context: Context) {}
}
