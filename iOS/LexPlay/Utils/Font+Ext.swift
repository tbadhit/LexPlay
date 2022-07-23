//
//  Font+Ext.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 04/07/22.
//

import SwiftUI

extension Font {
    static func lexendBlack(_ size: CGFloat = 16) -> Self {
        return .custom(FontStyle.lexendBlack, size: size)
    }

    static func lexendBold(_ size: CGFloat = 16) -> Self {
        return .custom(FontStyle.lexendBold, size: size)
    }

    static func lexendExtraBold(_ size: CGFloat = 16) -> Self {
        return .custom(FontStyle.lexendExtraBold, size: size)
    }

    static func lexendExtraLight(_ size: CGFloat = 16) -> Self {
        return .custom(FontStyle.lexendExtraLight, size: size)
    }

    static func lexendMedium(_ size: CGFloat = 16) -> Self {
        return .custom(FontStyle.lexendMedium, size: size)
    }

    static func lexendRegular(_ size: CGFloat = 16) -> Self {
        return .custom(FontStyle.lexendRegular, size: size)
    }

    static func lexendSemiBold(_ size: CGFloat = 16) -> Self {
        return .custom(FontStyle.lexendSemiBold, size: size)
    }

    static func lexendThin(_ size: CGFloat = 16) -> Self {
        return .custom(FontStyle.lexendThin, size: size)
    }
}
