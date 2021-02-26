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
  func addCard(_ card: Card, to deck: Deck) -> AnyPublisher<Void, Error> // TODO need to remove inout
}

class RealmDeckDataService: DeckDataService {
  
  // TODO delete this
  init() {
    decks = [Deck(name: "English to Spanish", frontSideSettings: SideSettings(side: .front, language: "en-US", autoPlay: false), backSideSettings: SideSettings(side: .back, language: "es-MX", autoPlay: true), cards: [Card(front: "Hello!", back: "¡Hola!"), Card(front: "How are you?", back: "¿Cómo estás?"), Card(front: "Where are you from?", back: "¿De donde eres?")]),
             Deck(name: "Español a Ingles"),
             Deck(name: "English to German", frontSideSettings: SideSettings(side: .front, language: "en-GB", autoPlay: false), backSideSettings: SideSettings(side: .back, language: "de_DE", autoPlay: true), cards: [Card(front: "Hello!", back: "Hallo!"), Card(front: "How are you?", back: "Wie geht es dir?"), Card(front: "Where are you from?", back: "Woher kommen Sie?")])]
  }
  
  var decks: [Deck]
//  var decks = [Deck]() // TODO
  
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
    return Future<Void, FlashError> { [weak self] promise in
      if deck.name.lowercased() != "aaa" {
        self?.decks.append(deck)
      }
      promise(.success(()))
    }
    .tryMap { item in
      if deck.name.lowercased() == "aaa" {
        throw FlashError.known
      } else {
        return item
      }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  func addCard(_ card: Card, to deck: Deck) -> AnyPublisher<Void, Error> {
    
    let deckFound = decks.first { $0.id == deck.id }
    if var deckFound = deckFound {
      deckFound.cards.append(card)
    }
    
    decks[3].cards.append(card)
    
    return Future { promise in
      promise(.success(()))
    }
    .eraseToAnyPublisher()
  }
  
}

