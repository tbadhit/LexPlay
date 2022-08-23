//
//  View+Ext.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 03/07/22.
//

import SwiftUI

extension View {
    func card() -> some View {
        return background(.white)
            .cornerRadius(32)
    }

    func cardPadding() -> some View {
        return padding(.horizontal, 32)
            .padding(.vertical, 16)
    }

    func scrollOnOverflow() -> some View {
        modifier(OverflowContentViewModifier())
    }

    func backgroundImage(_ name: String) -> some View {
        return background(Color.clear
            .overlay(
                Image(name)
                    .resizable()
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
            )
            .clipped()
            .edgesIgnoringSafeArea(.all))
    }

    @ViewBuilder
    func highlighted(tag name: GuidingAudio, highlightedComponent: GuidingAudio?, animationPhase: Binding<CGFloat>) -> some View {
        let _ = tag(name)
        if let activeComponent = highlightedComponent, activeComponent == name {
            overlay(RoundedRectangle(cornerRadius: 8)
                .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10], dashPhase: animationPhase.wrappedValue))
                .foregroundColor(.brandRed)
                .onAppear {
                    withAnimation(.linear.repeatForever(autoreverses: false)) {
                        animationPhase.wrappedValue -= 20
                    }
                })
        } else {
            self
        }
    }
}

extension View {
    @ViewBuilder
    func wrappedInScrollView(when condition: Bool) -> some View {
        if condition {
            ScrollView {
                self
            }
        } else {
            self
        }
    }
}
