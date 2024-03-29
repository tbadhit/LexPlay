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
        case hasOnboardedWatch
        case seedAlphabet
        case seedAvatar
        case isSavePicToGallery
    }

    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultsKey.hasOnboarded.rawValue)
        }

        set {
            setValue(newValue, forKey: UserDefaultsKey.hasOnboarded.rawValue)
        }
    }
    
    var hasOnboardedWatch: Bool {
        get {
            bool(forKey: UserDefaultsKey.hasOnboardedWatch.rawValue)
        }
        
        set {
            setValue(newValue, forKey: UserDefaultsKey.hasOnboardedWatch.rawValue)
        }
    }
    
    var isSavePicToGallery: Bool {
        get {
            bool(forKey: UserDefaultsKey.isSavePicToGallery.rawValue)
        }
        
        set {
            setValue(newValue, forKey: UserDefaultsKey.isSavePicToGallery.rawValue)
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

    var seedAvatar: Bool {
        get {
            bool(forKey: UserDefaultsKey.seedAvatar.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultsKey.seedAvatar.rawValue)
        }
    }
}
