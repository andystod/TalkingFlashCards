//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import Foundation

struct Card: Identifiable, Equatable {
  static func == (lhs: Card, rhs: Card) -> Bool {
    lhs.id == rhs.id &&
      lhs.selected == rhs.selected &&
      lhs.front.text == rhs.front.text &&
      lhs.back.text == rhs.back.text
  }
  
  let id: String = UUID().uuidString
  var front = CardSide(text: "")
  var back = CardSide(text: "")
  var selected = false
  var nextReviewDate: Date?
  var boxNumber: Int = 1 // TODO ??

  static var example: Card {
    Card(front: CardSide(text: "Hello! How are you? fsdfjasd fajsdlf asdfljasdf asldjf asdlfjk asdflkjasd fasjdf asldjf asdfjasldfkj asdfjlkasd;fjas;djfsajdfk asdfkljsd fajskldf; asdfjasd f"), back: CardSide(text: "¡Hola! ¿Cómo estás?"))
  }
}

struct CardSide {
  var id: String = UUID().uuidString
  var text: String
}

extension Array where Iterator.Element == Card {
  var hasSelectedItems: Bool {
    return self.contains { $0.selected }
    }
  }
  

