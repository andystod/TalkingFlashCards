//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import Foundation


struct Card: Identifiable {
  var id: UUID = UUID()
  var front: String = ""
  var back: String = ""

  static var example: Card {
    Card(front: "Front card text", back: "Back card text")
  }
}


  

