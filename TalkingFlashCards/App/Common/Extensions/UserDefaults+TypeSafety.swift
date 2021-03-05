//
//  UserDefaults+TypeSafety.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 28/02/2021.
//

import Foundation

//extension UserDefaults {
//
//  enum Keys {
//    static let voices = "voices"
//  }
//
//  class var voices: [String:Any] {
//    get { UserDefaults.standard.dictionary(forKey: Keys.voices) ?? [:] }
//    set { UserDefaults.standard.set(newValue, forKey: Keys.voices) }
//  }
//}

extension UserDefaults { // TODO try string:string
    @objc var voicePreferences: [String:String] {
        get {
          return dictionary(forKey: "voicePreferences") != nil ? dictionary(forKey: "voicePreferences") as! [String:String] : [String:String]()
        }
        set {
            set(newValue, forKey: "voicePreferences")
        }
    }
}
