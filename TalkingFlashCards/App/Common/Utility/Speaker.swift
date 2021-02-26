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
  
  func speak(_ text: String, language: String) {
    isSpeaking = true
    
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: language == "en-US" ? "en" : "es")
    utterance.rate = 0.4
    synth.speak(utterance)
  }
  
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    print("all done")
    
    isSpeaking = false
  }
}
