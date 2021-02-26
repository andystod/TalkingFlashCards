//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import Foundation


struct Card: Identifiable {
  let id: String = UUID().uuidString
  var front: String = ""
  var back: String = ""

  static var example: Card {
    Card(front: "Hello! How are you?", back: "¡Hola! ¿Cómo estás?")
  }
}


  

