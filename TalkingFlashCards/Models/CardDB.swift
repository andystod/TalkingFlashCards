//
//  CardDB.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 27/04/2021.
//

import Foundation
import RealmSwift

class CardDB: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var front: CardSideDB?
  @objc dynamic var back: CardSideDB?
  @objc dynamic var selected: Bool = false
  @objc dynamic var nextReviewDate: Date?
  @objc dynamic var boxNumber: Int = 1
  let deck = LinkingObjects(fromType: DeckDB.self, property: "cards")
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
  convenience init(_ card: Card) {
    self.init()
    self.id = card.id
    self.front = CardSideDB(card.front)
    self.back = CardSideDB(card.back)
    self.selected = card.selected
    self.nextReviewDate = card.nextReviewDate
    self.boxNumber = card.boxNumber
  }
  
  
}

class CardSideDB: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var text: String = ""
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
  convenience init(_ cardSide: CardSide) {
    self.init()
    self.id = cardSide.id
    self.text = cardSide.text
  }
}
