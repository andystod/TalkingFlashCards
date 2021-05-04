//
//  DeckStore.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 10/03/2021.
//

import Combine
import RealmSwift

class DeckStore: ObservableObject {
  
  @Published var decks = [Deck]()
  @Dependency var deckDataService: DeckDataService
  private var cancellables = Set<AnyCancellable>()
  
  init(callLoad: Bool = true) {
    if callLoad {
      loadDecks()
    }
  }
    
  private func loadDecks() {
    deckDataService.loadDecks()
      .sink { completion in
        switch completion {
        case .finished: break
        case let .failure(error):
          print(error)
        }
      } receiveValue: { [weak self] decksDB in
        self?.decks = decksDB.map(Deck.init)
      }
      .store(in: &cancellables)
  }
  
  func createDeck(_ deck: Deck) {
    objectWillChange.send()
    deckDataService.createDeck(deck: deck)
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          self?.decks.append(deck)
        case .failure(let error):
          print("error", error)
        }
      } receiveValue: { _ in }
      .store(in: &cancellables)
  }
  
  func updateDeck(_ deck: Deck) {
    objectWillChange.send()
    deckDataService.updateDeck(deck: deck)
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          self?.decks[(self?.deckIndexById(deck.id))!] = deck
        case .failure(let error):
          print(error)
        }
      } receiveValue: { _ in }
      .store(in: &cancellables)
  }
  
  func deckIndexById(_ id: String) -> Int {
    decks.firstIndex { $0.id == id }!
  }
  
  func deckById(_ id: String) -> Deck {
    decks.first { $0.id == id }!
  }
  
  /*
  decks.append(deck)
}

func updateDeck(_ deck: Deck) {
  objectWillChange.send()
  if let index = decks.firstIndex(where: { $0.id == deck.id }) {
    decks[index] = deck
  }
  */ 
  
}
