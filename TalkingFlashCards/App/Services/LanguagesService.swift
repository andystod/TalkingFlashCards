//
//  LanguagesService.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 18/02/2021.
//

import Foundation
import AVFoundation

protocol LanguageService {
  func getUniqueLanguages() -> [String]

}

struct LocalLanguageService: LanguageService {
  
  func getUniqueLanguages() -> [String] {
    let voices = AVSpeechSynthesisVoice.speechVoices()
    let locale = NSLocale.autoupdatingCurrent
    let languages = voices.map { locale.localizedString(forLanguageCode: $0.language) ?? "" }
    var uniqueLanguages = Array(Set(languages))
    uniqueLanguages.sort()
    return uniqueLanguages
  }
  
  
  
  
}
