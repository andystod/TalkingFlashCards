//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import Foundation

enum Side {
  case front, back
}

struct Deck: Identifiable {
  let id: String = UUID().uuidString
  var name: String = ""
  var description: String = ""
  var frontSideSettings = SideSettings(side: .front)
  var backSideSettings = SideSettings(side: .back, autoPlay: true)
  
  var cards = [Card]()
  
  var hasRequiredFieldsFilled: Bool {
    return !name.isEmpty // TODO && !frontSideSettings.language.isEmpty && !backSideSettings.language.isEmpty
  }
}

struct SideSettings {
  var side: Side
  var language: Language? = nil
  var autoPlay: Bool = false
}

  

