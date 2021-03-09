//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import SwiftUI
import Combine

enum Side {
  case front, back
}

struct Deck: Identifiable {
  let id: String = UUID().uuidString
  var name: String = ""
  var description: String = ""
  var frontSideSettings = SideSettings(side: .front)
  var backSideSettings = SideSettings(side: .back, autoPlay: true)
  
  var cards = [Card]()
  
  var hasRequiredFieldsFilled: Bool {
    return !name.isEmpty // TODO && !frontSideSettings.language.isEmpty && !backSideSettings.language.isEmpty
  }
  
//  var hasSelectedItems: Bool {
//    return cards.hasSelectedItems
//  }
}

struct SideSettings {
  var side: Side
  var languageCode: String = ""
  var autoPlay: Bool = false
}

extension Array where Iterator.Element == Card {
  var hasSelectedItems: Bool {
    return self.contains { $0.selected }
    }
  }
  

class DeckStore: ObservableObject {
  
  var decks = [Deck]()
  private var deckDataService: DeckDataService
  private var cancellables = Set<AnyCancellable>()
  
  init(deckDataService: DeckDataService = RealmDeckDataService()) {
    self.deckDataService = deckDataService
    loadDecks()
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
}

