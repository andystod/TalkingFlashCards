//
//  CardStore.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 10/03/2021.
//

import SwiftUI

class CardStore: ObservableObject {
  
  @Published var cards = [Card]()
  
  init() {
    
  }
  
  init(cards: [Card]) {
    self.cards = cards
  }
  
  func deleteCards() {
    cards.removeAll { $0.selected }
  }
}
