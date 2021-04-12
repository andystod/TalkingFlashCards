//
//  CardStore.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 10/03/2021.
//

import SwiftUI

class CardStore: ObservableObject {
  
  @Published var cards = [Card]()
  var cardManager = CardManager()
  
  init() {
    
  }
  
  init(cards: [Card]) {
    self.cards = cards
  }
  
  func deleteCards() {
    objectWillChange.send()
    cards.removeAll { $0.selected }
  }
  
  func addCard(_ card: Card) {
    objectWillChange.send()
    cards.append(card)
  }
  
  func updateCard(_ card: Card) {
    objectWillChange.send()
    if let index = cards.firstIndex(where: { $0.id == card.id }) {
      cards[index] = card
    }
  }
  
  func promoteCard(_ card: inout Card) {
    cardManager.promoteCard(&card)
  }
  
  func demoteCard(_ card: inout Card) {
    cardManager.demoteCard(&card)
  }
//  
////  func getNextReviewDate(card: Card) -> Date {
////    return Calendar.current.date(byAdding: .day, value: boxNumberOfDays[card.boxNumber], to: card.nextReviewDate ?? Date())!
////  }
}
