//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import Foundation


struct Card: Identifiable {
  let id: String = UUID().uuidString
  var front: CardSide
  var back: CardSide

  static var example: Card {
    Card(front: CardSide(text: "Hello! How are you? fsdfjasd fajsdlf asdfljasdf asldjf asdlfjk asdflkjasd fasjdf asldjf asdfjasldfkj asdfjlkasd;fjas;djfsajdfk asdfkljsd fajskldf; asdfjasd f"), back: CardSide(text: "¡Hola! ¿Cómo estás?"))
  }
}

struct CardSide {
  var text: String
}

  

