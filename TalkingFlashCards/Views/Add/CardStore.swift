//
//  CardStore.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 10/03/2021.
//

import SwiftUI
import Combine

class CardStore: ObservableObject {
  
  @Published var cards = [Card]()
  var cardManager = CardManager()
  var cardStore: CardDataService = RealmCardDataService()
  var cancellables = Set<AnyCancellable>()
  
  init() {
    
  }
  
  init(cards: [Card]) {
    self.cards = cards
  }
  
  func addCard(_ card: Card) {
    objectWillChange.send()
    cardStore.addCard(card)
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          self?.cards.append(card)
        case .failure(let error):
          print(error)
        }
      } receiveValue: { _ in }
      .store(in: &cancellables)
  }
  
  func updateCard(_ card: Card) {
    objectWillChange.send()
    cardStore.updateCard(card)
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          if let index = self?.cards.firstIndex(where: { $0.id == card.id }) {
            self?.cards[index] = card
          }
        case .failure(let error):
          print(error)
        }
      } receiveValue: { _ in }
      .store(in: &cancellables)
  }
  
  func deleteCards() {
    objectWillChange.send()
    let selectedCards = cards.compactMap {
      $0.selected ? $0 : nil
    }
    cardStore.deleteCards(selectedCards)
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          self?.cards.removeAll { $0.selected }
        case .failure(let error):
          print(error)
        }
      } receiveValue: { _ in }
      .store(in: &cancellables)
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
