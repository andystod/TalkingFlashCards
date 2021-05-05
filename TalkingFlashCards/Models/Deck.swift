//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import SwiftUI
import Combine
import RealmSwift

@objc enum Side: Int, RealmEnum {
  case front, back
}

struct Deck: Identifiable {
  var id: String = UUID().uuidString
  var name: String = ""
  var desc: String = ""
  var frontSideSettings = SideSettings(side: .front)
  var backSideSettings = SideSettings(side: .back, autoPlay: true)
  var cardStore: CardStore
  var cancellables = Set<AnyCancellable>()
  
  init() {
    id = UUID().uuidString
    cardStore = CardStore(deckId: id)
  }
  
  var hasRequiredFieldsFilled: Bool {
    return !name.isEmpty && !frontSideSettings.languageCode.isEmpty && !backSideSettings.languageCode.isEmpty
  }
  
}

extension Deck {
  init(deckDB: DeckDB) {
    id = deckDB.id
    name = deckDB.name
    desc = deckDB.desc
    frontSideSettings = SideSettings(deckDB.frontSideSettings)
    backSideSettings = SideSettings(deckDB.backSideSettings)
    cardStore = CardStore(deckId: deckDB.id)
    cardStore.loadCards()
  }
  
  init(name: String) {
    self.name = name
    self.cardStore = CardStore()
  }
  
  init(cardStore: CardStore) {
    self.cardStore = cardStore
  }
  
}



struct SideSettings {
  var id: String = UUID().uuidString
  var side: Side = .front
  var languageCode: String = ""
  var autoPlay: Bool = false
  
  init(side: Side, autoPlay: Bool = false) {
    self.side = side
    self.autoPlay = autoPlay
  }
  
  init(_ sideSettingsDB: SideSettingsDB?) {
    if let sideSettingsDB = sideSettingsDB {
      id = sideSettingsDB.id
      side = sideSettingsDB.side
      languageCode = sideSettingsDB.languageCode
      autoPlay = sideSettingsDB.autoPlay
    }
  }
}



