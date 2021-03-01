//
//  UserDefaults+TypeSafety.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 28/02/2021.
//

import Foundation

extension UserDefaults {
  
  private enum Keys {
    static let voices = "voices"
  }
  
  class var voices: [String:Any] {
    get { UserDefaults.standard.dictionary(forKey: Keys.voices) ?? [:] }
    set { UserDefaults.standard.set(newValue, forKey: Keys.voices) }
  }
  
}
