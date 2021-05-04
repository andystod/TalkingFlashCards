//
//  DeckDB.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 13/04/2021.
//
import Foundation
import RealmSwift

class DeckDB: Object {
  @objc dynamic var id: String = UUID().uuidString
  @objc dynamic var name: String = ""
  @objc dynamic var desc: String = ""
  @objc dynamic var frontSideSettings: SideSettingsDB?
  @objc dynamic var backSideSettings: SideSettingsDB?
  dynamic var cards = List<CardDB>()
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
  convenience init(_ deck: Deck) {
    self.init()
    id = deck.id
    name = deck.name
    desc = deck.desc
    frontSideSettings = SideSettingsDB(deck.frontSideSettings)
    backSideSettings = SideSettingsDB(deck.backSideSettings)
  }
  
}

class SideSettingsDB: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var side: Side = .front
  @objc dynamic var languageCode: String = ""
  @objc dynamic var autoPlay: Bool = false
  var parentCategory: LinkingObjects<DeckDB> = LinkingObjects(fromType: DeckDB.self, property: "frontSideSettings" )
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
  convenience init(_ sideSettings: SideSettings){
    self.init()
    id = sideSettings.id
    side = sideSettings.side
    languageCode = sideSettings.languageCode
    autoPlay = sideSettings.autoPlay
    if side == .back {
      parentCategory = LinkingObjects(fromType: DeckDB.self, property: "backSideSettings" )
    }
  }
  
//  convenience init(side: Side, languageCode: String, autoPlay: Bool = false){
//    self.init()
//    self.side = side
//    self.languageCode = languageCode
//    self.autoPlay = autoPlay
//    if side == .back {
//      self.parentCategory = LinkingObjects(fromType: DeckDB.self, property: "backSideSettings" )
//    }
//  }
  
}



