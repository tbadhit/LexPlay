//
//  UserDefault+Ext.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 01/07/22.
//

import Foundation

extension UserDefaults {
  private enum UserDefaultsKey: String {
    case hasOnboarded
    case seedAlphabet
  }
  
  var hasOnboarded: Bool {
    get {
      bool(forKey: UserDefaultsKey.hasOnboarded.rawValue)
    }
    
    set {
      setValue(newValue, forKey: UserDefaultsKey.hasOnboarded.rawValue)
    }
  }
    
  var seedAlphabet: Bool {
    get {
      bool(forKey: UserDefaultsKey.seedAlphabet.rawValue)
    }
    set {
      setValue(newValue, forKey: UserDefaultsKey.seedAlphabet.rawValue)
    }
  }
}
