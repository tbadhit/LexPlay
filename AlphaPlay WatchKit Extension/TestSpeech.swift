//
//  TestSpeech.swift
//  AlphaPlay WatchKit Extension
//
//  Created by Tubagus Adhitya Permana on 21/07/22.
//

import SwiftUI
import WatchKit

extension View {
    
    typealias StringCompletion = (String) -> Void
    
    func presentInputController(withSuggestions suggestions: [String], completion: @escaping StringCompletion) {
        WKExtension.shared()
            .visibleInterfaceController?
            .presentTextInputController(
                withSuggestions: suggestions,
                                        allowedInputMode: .plain) { result in

                guard let result = result as? [String], let firstElement = result.first else {
                    completion("")
                    return
                }

                completion(firstElement)
            }
    }
}

struct TestSpeech: View {
    
    @State var text = "Hold to speak"
    @State var alphabet = "a"
    @State var next = false
    
    var body: some View {
        Button {
            let newAlphabet = presentInputController()
            print(newAlphabet)
            if alphabet.lowercased() == newAlphabet {
                print("Kata ini berisikan huruf a")
                next = true
            } else {
                print("Kata ini tidak berisikan huruf a")
            }
        } label: {
            Text("Press this button")
        }
        .background(NavigationLink(isActive: $next) {
            TestSpeech2()
        } label: {
            EmptyView()
        })
    }
    
    func presentInputController() -> String {
        var alphabet = ""
        presentInputController(withSuggestions: []) {
            result in
            alphabet = result.first?.lowercased() ?? ""
        }
        
        return alphabet
    }
}
struct TestSpeech2: View {
    
    var body: some View {
        Text("Hallo")

    }
}



struct TestSpeech_Previews: PreviewProvider {
    static var previews: some View {
        TestSpeech()
    }
}
