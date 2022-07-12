//
//  CardSays.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 08/07/22.
//

import SwiftUI

struct CardSays: View {
    let imageName: String
    let information: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: imageName == "lex" ? 108 : 104, height: imageName == "lex" ? 182 : 123)
                .scaledToFit()
                .offset(y: 14)
                .padding(.trailing, 10)

            Text(information)
                .font(.lexendMedium(21))
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .card()
    }
}

struct CardSays_Previews: PreviewProvider {
    static var previews: some View {
        CardSays(imageName: "lex", information: "Blablablabla")
    }
}
