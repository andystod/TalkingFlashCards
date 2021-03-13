//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import Foundation


struct Card: Identifiable {
  let id: String = UUID().uuidString
  var front = CardSide(text: "")
  var back = CardSide(text: "")
  var selected = false

  static var example: Card {
    Card(front: CardSide(text: "Hello! How are you? fsdfjasd fajsdlf asdfljasdf asldjf asdlfjk asdflkjasd fasjdf asldjf asdfjasldfkj asdfjlkasd;fjas;djfsajdfk asdfkljsd fajskldf; asdfjasd f"), back: CardSide(text: "¡Hola! ¿Cómo estás?"))
  }
}

struct CardSide {
  var text: String
}

extension Array where Iterator.Element == Card {
  var hasSelectedItems: Bool {
    return self.contains { $0.selected }
    }
  }
  

