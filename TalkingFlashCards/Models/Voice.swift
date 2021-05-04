//
//  VoiceModel.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 02/03/2021.
//

import Foundation
import AVFoundation

struct Voice: Identifiable, Hashable {
  var id: String { return identifier }
  var identifier = ""
  var languageCode = ""
  var languageAndRegionCode = ""
  var languageAndRegionDescription = ""
  var name = ""
  var defaultItem = false
  
  init(voice: AVSpeechSynthesisVoice) {
    identifier = voice.identifier
    languageAndRegionCode = voice.language
    languageCode = languageAndRegionCode.components(separatedBy: "-")[0]
    let locale = NSLocale.autoupdatingCurrent
    languageAndRegionDescription =  locale.localizedString(forIdentifier: languageAndRegionCode) ?? languageAndRegionCode
    name = voice.name
  }
  
  init(identifier: String) {
    let avVoice = AVSpeechSynthesisVoice(identifier: identifier)
    if let avVoice = avVoice {
      self.init(voice: avVoice)
    } else {
      self.init(defaultItem: true)
    }
  }
  
  init(defaultItem: Bool) {
    if defaultItem {
      self.defaultItem = defaultItem
      identifier = "Default"
      languageAndRegionDescription = "Default"
    }
  }
  
}
