//
//  DeckDataService.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import Foundation
import Combine

protocol DeckDataService {
  func getDecks() -> AnyPublisher<[Deck], Error>
  func createDeck(deck: Deck) -> AnyPublisher<Void, Error>
}

class RealmDeckDataService: DeckDataService {
  
  var decks = [Deck]()
  
  //      promise(.success([Deck(id: UUID(), name: "Deck1"),
  //                        Deck(id: UUID(), name: "Deck2"),
  //                        Deck(id: UUID(), name: "Deck4")]))
  //      promise(.failure(URLError(URLError.Code.badURL)))

  
  func getDecks() -> AnyPublisher<[Deck], Error> {
    return Future<[Deck], Error> { [weak self] promise in
      promise(.success(self!.decks))
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  func createDeck(deck: Deck) -> AnyPublisher<Void, Error> {
    return Future { [weak self] promise in
      self?.decks.append(deck)
      promise(.success(()))
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
}
