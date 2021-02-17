//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import Foundation


struct Deck: Identifiable {
  var id: UUID = UUID()
  var name: String = ""
  var description: String = ""
  var frontSideSettings = SideSettings()
  var backSideSettings = SideSettings()
}

struct SideSettings {
  var language: String = ""
  var autoPlay: Bool = false
}

  

