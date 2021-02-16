//
//  DeckDataService.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import Foundation
import Combine

protocol DeckDataService {
  func getDecks() -> Future<[Deck], Error>
}

class RealmDeckDataService: DeckDataService {
  
  func getDecks() -> Future<[Deck], Error> {
    return Future { promise in
      promise(.success([Deck(id: UUID(), name: "Deck1"),
                        Deck(id: UUID(), name: "Deck2"),
                        Deck(id: UUID(), name: "Deck4")]))
//      promise(.failure(URLError(URLError.Code.badURL)))
    }
  }
  
  
}
