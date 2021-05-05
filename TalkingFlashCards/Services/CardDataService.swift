//
//  CardDataService.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 27/04/2021.
//

import Foundation
import RealmSwift
import Combine

protocol CardDataService {
  func loadCards(deckId: String) -> AnyPublisher<[Card], FlashError>
  func addCard(_ card: Card, deckId: String) -> AnyPublisher<Void, FlashError>
  func updateCard(_ card: Card) -> AnyPublisher<Void, FlashError>
  func deleteCards(_ cards: [Card], deckId: String) -> AnyPublisher<Void, FlashError>
}

class RealmCardDataService: CardDataService {
  
  func loadCards(deckId: String) -> AnyPublisher<[Card], FlashError> {
    Future { promise in
      let realm = try! Realm()
      let cardsDB = realm.objects(CardDB.self).filter("ANY deck.id = %@", deckId)
      promise(.success(cardsDB.map(Card.init)))
    }
    .eraseToAnyPublisher()
  }
  
  func addCard(_ card: Card, deckId: String)  -> AnyPublisher<Void, FlashError> {
    Future { promise in
      do {
        let realm = try Realm()
        let deck = realm.object(ofType: DeckDB.self, forPrimaryKey: deckId)
        if let deck = deck {
          try realm.write
          {
            deck.cards.append(CardDB(card))
            realm.add(deck, update: .modified)
            promise(.success(()))
          }
        }
      } catch {
        promise(.failure(FlashError.unknown))
      }
    }
    .eraseToAnyPublisher()
  }
  
  
  func updateCard(_ card: Card) -> AnyPublisher<Void, FlashError> {
    Future { promise in
      do {
        let realm = try Realm()
        try realm.write {
          let cardDB = CardDB(card)
          realm.add(cardDB, update: .all)
          promise(.success(()))
        }
      }
      catch {
        promise(.failure(FlashError.unknown))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func deleteCards(_ cards: [Card], deckId: String) -> AnyPublisher<Void, FlashError> {
    Future { promise in
      do {
        let realm = try Realm()
        let cardsToDelete = realm.objects(CardDB.self).filter(NSPredicate(format: "id IN %@", cards.map { $0.id }))
        
        let sideIds: [String] = cardsToDelete.map { cardDB in
          [cardDB.front?.id, cardDB.back?.id]
        }.flatMap { $0 }
        .compactMap { $0 }
        let cardSidesToDelete = realm.objects(CardSideDB.self).filter(NSPredicate(format: "id IN %@", sideIds))
        
        try realm.write {
          realm.delete(cardSidesToDelete)
          realm.delete(cardsToDelete)
          promise(.success(()))
        }
      } catch {
        promise(.failure(FlashError.unknown))
      }
    }
    .eraseToAnyPublisher()
  }
}
