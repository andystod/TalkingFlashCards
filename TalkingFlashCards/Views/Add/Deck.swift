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
  var id: UUID = UUID()
  var name: String = ""
  var description: String = ""
  var frontSideSettings = SideSettings(side: .front)
  var backSideSettings = SideSettings(side: .back, autoPlay: true)
  
  var cards = [Card](repeating: Card.example, count: 3)
  
  var hasRequiredFieldsFilled: Bool {
    return !name.isEmpty && !frontSideSettings.language.isEmpty && !backSideSettings.language.isEmpty
  }
}

struct SideSettings {
  var side: Side
  var language: String = ""
  var autoPlay: Bool = false
}

  

