//
//  DeckDataService.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import Foundation
import Combine

protocol DeckDataService {
  func loadDecks() -> AnyPublisher<[Deck], Error>
  func createDeck(deck: Deck) -> AnyPublisher<Void, FlashError> // TODO check on error type and use of trymap and maperror
  func updateDeck(deck: Deck) -> AnyPublisher<Void, Error>
//  func addCard(_ card: Card, to deck: Deck) -> AnyPublisher<Void, Error> // TODO need to remove inout
  func deleteCards() -> AnyPublisher<Void, FlashError>
}

class RealmDeckDataService: DeckDataService {
  
  // TODO delete this
  init() {
    
    // TODO
    //        decks = [Deck]()
    
    decks = [
      Deck(name: "English to Spanish", frontSideSettings: SideSettings(side: .front, languageCode: "en", autoPlay: false), backSideSettings: SideSettings(side: .back, languageCode: "es", autoPlay: true),
           cardStore: CardStore(cards: [
            Card(front: CardSide(text: "Hello!"), back: CardSide(text: "¡Hola!")),
            Card(front: CardSide(text: "How are you?"), back: CardSide(text: "¿Cómo estás?")),
            Card(front: CardSide(text: "Australia"), back: CardSide(text: "Australia")),
            Card(front: CardSide(text: "Where are you from?"), back: CardSide(text: "¿De donde eres?"))
           ])),
      Deck(name: "Español a Ingles"),
      Deck(name: "English to German", frontSideSettings: SideSettings(side: .front, languageCode: "en", autoPlay: false), backSideSettings: SideSettings(side: .back, languageCode: "de", autoPlay: true),
           cardStore: CardStore(cards: [
            Card(front: CardSide(text: "Hello!"), back: CardSide(text: "Hallo!")),
            Card(front: CardSide(text: "How are you?"), back: CardSide(text: "Wie geht es dir?")),
            Card(front: CardSide(text: "Where are you from?"), back: CardSide(text: "Woher kommen Sie?"))
           ]))
    ]
  }
  
  var decks: [Deck]
  //  var decks = [Deck]() // TODO
  
  //      promise(.success([Deck(id: UUID(), name: "Deck1"),
  //                        Deck(id: UUID(), name: "Deck2"),
  //                        Deck(id: UUID(), name: "Deck4")]))
  //      promise(.failure(URLError(URLError.Code.badURL)))
  
  
  func loadDecks() -> AnyPublisher<[Deck], Error> {
    return Future<[Deck], Error> { [weak self] promise in
      promise(.success(self!.decks))
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  func createDeck(deck: Deck) -> AnyPublisher<Void, FlashError> {
    return Future<Void, FlashError> { [weak self] promise in
      self?.decks.append(deck)
      promise(.success(()))
    }
    //    .tryMap{ _ in }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  func updateDeck(deck: Deck) -> AnyPublisher<Void, Error> {
    return Future<Void, Error> { [weak self] promise in
      if let index = self?.decks.firstIndex(where: { $0.id == deck.id }) {
        self?.decks[index] = deck
        promise(.success(()))
      } else {
        promise(.failure(FlashError.unknown))
      }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
//  func addCard(_ card: Card, to deck: Deck) -> AnyPublisher<Void, Error> {
//
//    let deckFound = decks.first { $0.id == deck.id }
//    if var deckFound = deckFound {
//      deckFound.cards.append(card)
//    }
//
//    //    decks[3].cards.append(card)
//
//    return Future { promise in
//      promise(.success(()))
//    }
//    .receive(on: DispatchQueue.main)
//    .eraseToAnyPublisher()
//  }
  
  func deleteCards() -> AnyPublisher<Void, FlashError> {
    //    deck.cards.removeAll { $0.selected }
    
    return Future { promise in
      promise(.success(()))
    }
    .eraseToAnyPublisher()
  }
  
}

