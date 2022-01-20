//
//  DeckDataService.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import Foundation
import Combine
import RealmSwift

protocol DeckDataServiceProtocol {
  func loadDecks() -> AnyPublisher<Results<DeckDB>, Error>
  func createDeck(deck: Deck) -> AnyPublisher<Void, FlashError>
  func updateDeck(deck: Deck) -> AnyPublisher<Void, Error>
//  func deleteDeck(deck: Deck) -> AnyPublisher<Void, FlashError> // TODO
}

class DeckDataService: DeckDataServiceProtocol {
   
  func loadDecks() -> AnyPublisher<Results<DeckDB>, Error> {
    return Future<Results<DeckDB>, Error> { promise in
      do {
      let realm = try Realm()
      let decks = realm.objects(DeckDB.self)
      print(decks)
      promise(.success(decks))
      } catch let error {
        promise(.failure(error))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func createDeck(deck: Deck) -> AnyPublisher<Void, FlashError> {
    return Future<Void, FlashError> { promise in
      do {
        let realm = try Realm()
        let deckDB = DeckDB(deck)
        try realm.write {
          realm.add(deckDB)
          promise(.success(()))
        }
      } catch {
        promise(.failure(FlashError.unknown))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func updateDeck(deck: Deck) -> AnyPublisher<Void, Error> {
    return Future<Void, Error> { promise in
      do {
        let realm = try Realm()
        let deckDB = DeckDB(deck)
        try realm.write {
          realm.add(deckDB, update: .all)
          promise(.success(()))
        }
      } catch {
        promise(.failure(FlashError.unknown))
      }
    }
    .eraseToAnyPublisher()
  }
}

