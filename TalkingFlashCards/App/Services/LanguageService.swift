//
//  LanguagesService.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 18/02/2021.
//

import Foundation
import AVFoundation

protocol LanguageService {
  func getUniqueLanguages() -> [Language]
  
}

struct Language: Hashable, Comparable {
  var languageCode: String
  var languageAndRegionCode: String
  var displayValue: String
  
  static func < (lhs: Language, rhs: Language) -> Bool {
    lhs.displayValue < rhs.displayValue
  }
}

struct LocalLanguageService: LanguageService {
  
  var defaultLocalForLanguages = ["en":"en-US", "zh":"zh-CN", "es":"es-MX", "fr":"fr-FR", "nl":"nl-NL", "pt-BR":"pt-BR"]
  
  
  // TODO store this in environment
  func getUniqueLanguages() -> [Language] {
    
    
    
    
    let voices = AVSpeechSynthesisVoice.speechVoices()
    let locale = NSLocale.autoupdatingCurrent
    var languages = voices.map { Language(languageCode:$0.language.components(separatedBy: "-")[0], languageAndRegionCode: $0.language, displayValue: locale.localizedString(forLanguageCode: $0.language) ?? "") }
    
    
    var uniqueLanguages = languages.removingDuplicates(byKey: \.languageCode)
    
    uniqueLanguages = uniqueLanguages.map { language -> (Language) in
      var _language = language
      if let defaultLanguage = defaultLocalForLanguages[language.languageCode] {
        _language.languageAndRegionCode = defaultLanguage
      }
      return _language
    }
    
    var v = getVoicesForLanguage("en")
    
    
    uniqueLanguages.sort()
    
    
    return uniqueLanguages
  }
  
  func getVoicesForLanguage(_ languageCode: String) -> [AVSpeechSynthesisVoice] {
    let voices = AVSpeechSynthesisVoice.speechVoices()
    let locale = NSLocale.autoupdatingCurrent
    let filteredVoices = voices.filter { voice in
      voice.language.hasPrefix(languageCode)
    }
    return filteredVoices
  }
  
  
}
