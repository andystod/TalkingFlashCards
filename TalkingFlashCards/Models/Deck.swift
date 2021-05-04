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
  
  //  var cards = [Card]()
  
  var cardStore = CardStore()
  //  @Dependency var deckDataService: DeckDataService
  var cancellables = Set<AnyCancellable>()
  //  @Published var result: Result<Void, Error>?
  
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



