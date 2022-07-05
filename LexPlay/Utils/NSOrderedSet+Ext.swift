//
//  NSOrderedSet+Ext.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 05/07/22.
//

import Foundation

extension NSOrderedSet {
    func toArray<T>(of type: T.Type) -> [T] {
        array.compactMap { $0 as? T }
    }
}
