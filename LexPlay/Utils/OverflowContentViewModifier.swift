//
//  OverflowContentViewModifier.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 09/07/22.
//

import SwiftUI

struct OverflowContentViewModifier: ViewModifier {
    @State private var contentOverflow: Bool = false
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .background(
                    GeometryReader {contentGeometry in
                        Color.clear.onAppear {
                            print("konten geometri : \(contentGeometry.size.height)")
                            print("kalau konten lebih dari geometri true")
                            print("geometry \(geometry.size.height)")
                            contentOverflow = contentGeometry.size.height > geometry.size.height
                        }
                    }
                )
                .wrappedInScrollView(when: contentOverflow)
        }
    }
}
