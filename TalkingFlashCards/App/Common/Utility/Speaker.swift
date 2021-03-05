//
//  Speaker.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 21/02/2021.
//

import Foundation

import AVFoundation
import Combine

class Speaker: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
  let synth = AVSpeechSynthesizer()
  
  override init() {
    super.init()
    synth.delegate = self
  }
  
  @Published var isSpeaking: Bool = false
  
  func speak(_ text: String, languageCode: String) {
    isSpeaking = true
    
    let utterance = AVSpeechUtterance(string: text)
    
    let voicePrefs = UserDefaults.standard.voicePreferences
    let identifier = voicePrefs[languageCode]
    if let identifier = identifier {
      utterance.voice = AVSpeechSynthesisVoice(identifier: identifier)
    } else {
      utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
    }
    utterance.rate = 0.4
    
    // Enable sound when on silent mode
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
    } catch(let error) {
      print(error.localizedDescription)
    }
    
    synth.speak(utterance)
  }
  
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    print("all done")
    
    isSpeaking = false
  }
}
