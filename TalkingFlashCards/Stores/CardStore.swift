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
  @Dependency var cardDataService: CardDataServiceProtocol
  var cancellables = Set<AnyCancellable>()
  var deckId = ""
  @Published var allCardsReviewed = false
  var answersCorrect = 0
  var answersWrong = 0
  
//  init() { }
  
  init(deckId: String = "") {
    self.deckId = deckId
//    cards.publisher.sink { [weak self] _ in
//      self?.objectWillChange.send()
//      self!.allCardsReviewed = self!.cards.allCardsReviewed
//    }
//    .store(in: &cancellables)
    
    
  }
  
  init(cards: [Card]) {
    self.cards = cards
  }
  
  func loadCards() {
    objectWillChange.send()
    cardDataService.loadCards(deckId: deckId)
      .sink { completion in
        switch completion {
        case .finished:
          print("Cards Load completed")
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] cards in
        self?.cards = cards
      }
      .store(in: &cancellables)
  }
  
  func addCard(_ card: Card) {
    objectWillChange.send()
    cardDataService.addCard(card, deckId: deckId)
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
    cardDataService.updateCard(card)
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
    cardDataService.deleteCards(selectedCards, deckId: deckId)
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
    answersCorrect += 1
    checkAllCardsReviewed()
  }
  
  func demoteCard(_ card: inout Card) {
    cardManager.demoteCard(&card)
    answersWrong += 1
    checkAllCardsReviewed()
  }
  
  func checkAllCardsReviewed() {
    if cards.count - answersCorrect - answersWrong == 0 {
      objectWillChange.send()
      self.allCardsReviewed = true
    }
  }
  
  func resetReviewProperties() {
    self.allCardsReviewed = false
    self.answersWrong = 0
    self.answersCorrect = 0
  }
  
  //
  ////  func getNextReviewDate(card: Card) -> Date {
  ////    return Calendar.current.date(byAdding: .day, value: boxNumberOfDays[card.boxNumber], to: card.nextReviewDate ?? Date())!
  ////  }
}
