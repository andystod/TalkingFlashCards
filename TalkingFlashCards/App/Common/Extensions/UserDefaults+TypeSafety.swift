//
//  UserDefaults+TypeSafety.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 28/02/2021.
//

import Foundation

extension UserDefaults {
    @objc var voicePreferences: [String:String] {
        get {
          return dictionary(forKey: "voicePreferences") != nil ? dictionary(forKey: "voicePreferences") as! [String:String] : [String:String]()
        }
        set {
            set(newValue, forKey: "voicePreferences")
        }
    }
}
