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
