//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import SwiftUI
import Combine

enum Side {
  case front, back
}

struct Deck: Identifiable {
  let id: String = UUID().uuidString
  var name: String = ""
  var description: String = ""
  var frontSideSettings = SideSettings(side: .front)
  var backSideSettings = SideSettings(side: .back, autoPlay: true)
  
//  var cards = [Card]()
  
  var cardStore = CardStore()
//  @Dependency var deckDataService: DeckDataService
  var cancellables = Set<AnyCancellable>()
//  @Published var result: Result<Void, Error>?
  
  var hasRequiredFieldsFilled: Bool {
    return !name.isEmpty && !frontSideSettings.languageCode.isEmpty && !backSideSettings.languageCode.isEmpty
  }
  
//  init() {
//    
//  }
//  
//  init(name: String) {
//    self.name = name
//  }
//  
//  init(cards: [Card]) {
//    self.cards = cards
//  }
//  
//  init(name: String, frontSideSettings: SideSettings, backSideSettings: SideSettings, cards: [Card]) {
//    self.name = name
//    self.frontSideSettings = frontSideSettings
//    self.backSideSettings = backSideSettings
//    self.cards = cards
//  }
  
  //  var hasSelectedItems: Bool {
  //    return cards.hasSelectedItems
  //  }
}


struct SideSettings {
  var side: Side
  var languageCode: String = ""
  var autoPlay: Bool = false
}



