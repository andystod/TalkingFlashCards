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
  func getVoicesForLanguage(_ languageCode: String) -> [AVSpeechSynthesisVoice] 
  
}

struct Language: Hashable, Comparable {
  var languageCode: String
  var languageAndRegionCode: String
  var displayValue: String
//  var languageAndRegionDisplayValue: String
  
  init(languageAndRegionCode: String) {
    let locale = NSLocale.autoupdatingCurrent
    self.languageCode = languageAndRegionCode.components(separatedBy: "-")[0]
    self.languageAndRegionCode = languageAndRegionCode
    displayValue = locale.localizedString(forLanguageCode: languageAndRegionCode) ?? ""
//    languageAndRegionDisplayValue = locale.localizedString(forIdentifier: <#T##String#>: languageAndRegionCode) ?? ""
  }
  
  static func < (lhs: Language, rhs: Language) -> Bool {
    lhs.displayValue < rhs.displayValue
  }
}

struct LocalLanguageService: LanguageService {
  
  var defaultLocalForLanguages = ["en":"en-US", "zh":"zh-CN", "es":"es-MX", "fr":"fr-FR", "nl":"nl-NL", "pt-BR":"pt-BR"]
  
  
  // TODO store this in environment
  func getUniqueLanguages() -> [Language] {
    
    
    
    
    let voices = AVSpeechSynthesisVoice.speechVoices()
    let languages = voices.map { Language(languageAndRegionCode: $0.language) }
        
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

extension AVSpeechSynthesisVoice {
  var languageAndRegionDescription: String {
    let locale = NSLocale.autoupdatingCurrent
    return locale.localizedString(forIdentifier: language) ?? language
  }
}
