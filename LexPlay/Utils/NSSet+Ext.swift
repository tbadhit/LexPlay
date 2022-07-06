//
//  NSSet+Ext.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 05/07/22.
//

import Foundation

extension NSSet {
    func toArray<T>(of type: T.Type) -> [T] {
        allObjects.compactMap { $0 as? T }
    }
}
