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
    func highlighted(tag name: GuidingAudio, highlightedComponent: GuidingAudio?, animationPhase: CGFloat) -> some View {
        let v = tag(name)
        if highlightedComponent == name {
            v.overlay(RoundedRectangle(cornerRadius: 8)
                .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10], dashPhase: animationPhase))
                .foregroundColor(.brandRed)
                .animation(.linear.repeatForever(autoreverses: false), value: animationPhase))
        } else {
            v
        }
    }

    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillDisappearModifier(callback: perform))
    }

    func onDidAppear(_ perform: @escaping () -> Void) -> some View {
        modifier(DidAppearModifier(callback: perform))
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

fileprivate struct ViewObserver: UIViewControllerRepresentable {
    func makeCoordinator() -> ViewObserver.Coordinator {
        Coordinator(onDidAppear: onDidAppear, onWillDisappear: onWillDisappear)
    }

    var onDidAppear: () -> Void = {}
    var onWillDisappear: () -> Void = {}

    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewObserver>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ViewObserver>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        var onDidAppear: () -> Void = {}
        var onWillDisappear: () -> Void = {}

        init(onDidAppear: @escaping () -> Void, onWillDisappear: @escaping () -> Void) {
            self.onDidAppear = onDidAppear
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            onDidAppear()
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

fileprivate struct WillDisappearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(ViewObserver(onWillDisappear: callback))
    }
}

fileprivate struct DidAppearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content.background(ViewObserver(onDidAppear: callback))
    }
}
