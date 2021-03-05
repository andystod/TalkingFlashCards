//
//  GlobalData.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 03/03/2021.
//

import Foundation

class GlobalData:ObservableObject {
  
  static let shared = GlobalData()
  
  private init() { }
  
  let languageData = LanguageData()
  
}
