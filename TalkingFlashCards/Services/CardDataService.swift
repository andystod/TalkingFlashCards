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
//  func loadCards(
  func addCard(_ card: Card) -> AnyPublisher<Void, FlashError>
  func updateCard(_ card: Card) -> AnyPublisher<Void, FlashError>
  func deleteCards(_ cards: [Card]) -> AnyPublisher<Void, FlashError>
}

class RealmCardDataService: CardDataService {
  func addCard(_ card: Card)  -> AnyPublisher<Void, FlashError> {
    Future { promise in
      do {
        let realm = try Realm()
        try realm.write
        {
          realm.add(CardDB(card))
          promise(.success(()))
        }
      } catch {
        promise(.failure(FlashError.unknown))
      }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  
  func updateCard(_ card: Card) -> AnyPublisher<Void, FlashError> {
    Future { promise in
      
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  func deleteCards(_ cards: [Card]) -> AnyPublisher<Void, FlashError> {
    Future { promise in
      do {
        let realm = try Realm()
        let objectsToDelete = realm.objects(CardDB.self).filter(NSPredicate(format: "id IN %@", cards.map { $0.id }))
        if objectsToDelete.count > 0 {
          try realm.write {
            realm.delete(objectsToDelete)
            promise(.success(()))
          }
        } else {
          promise(.failure(FlashError.unknown))
        }
      } catch {
        promise(.failure(FlashError.unknown))
      }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  
}
