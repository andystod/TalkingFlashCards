//
//  DeckStore.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 10/03/2021.
//

import Combine

class DeckStore: ObservableObject {
  
  @Published var decks = [Deck]()
  @Dependency var deckDataService: DeckDataService
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    loadDecks()
  }
  
  init(decks: [Deck]) {
    self.decks = decks
  }
  
  private func loadDecks() {
    deckDataService.loadDecks()
      .sink { completion in
        
        if case let .failure(error) = completion {
          print(error)
        }
        
        
        switch completion {
        case .finished: break
        case let .failure(error):
          print(error)
        }
      } receiveValue: { [weak self] decks in
        self?.decks = decks
        print(self?.decks.indices)
      }
      .store(in: &cancellables)
  }
  
  func createDeck(_ deck: Deck) {
    objectWillChange.send()
    decks.append(deck)
  }
  
  func updateDeck(_ deck: Deck) {
    objectWillChange.send()
    if let index = decks.firstIndex(where: { $0.id == deck.id }) {
      decks[index] = deck
    }
  }
  
  func deckById(_ id: String) -> Deck {
    decks.first { $0.id == id }!
  }
  
}
