//
//  Deck.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 16/02/2021.
//

import Foundation

struct Card: Identifiable, Equatable {
  
  var id: String = UUID().uuidString
  var front = CardSide(text: "", side: .front)
  var back = CardSide(text: "", side: .back)
  var selected = false
  var nextReviewDate: Date?
  var boxNumber: Int = 1 // TODO ??
  var rotationAngleOffset: Double = Double.random(in: -0.5...0.5)
//  var reviewed = false
//  var answerCorrect = false
  
  static func == (lhs: Card, rhs: Card) -> Bool {
    lhs.id == rhs.id &&
      lhs.selected == rhs.selected &&
      lhs.front.text == rhs.front.text &&
      lhs.back.text == rhs.back.text
  }
  
  static var example: Card {
    Card(front: CardSide(text: "Hello! How are you? fsdfjasd fajsdlf asdfljasdf asldjf asdlfjk asdflkjasd fasjdf asldjf asdfjasldfkj asdfjlkasd;fjas;djfsajdfk asdfkljsd fajskldf; asdfjasd f"), back: CardSide(text: "¡Hola! ¿Cómo estás?"))
  }
}

extension Card {
  init(_ cardDB: CardDB) {
    self.id = cardDB.id
    self.front = CardSide(cardDB.front)
    self.back = CardSide(cardDB.back)
    self.selected = cardDB.selected
    self.nextReviewDate = cardDB.nextReviewDate
    self.boxNumber = cardDB.boxNumber
  }
}


struct CardSide {
  var id: String = UUID().uuidString
  var text: String = ""
  var side: Side = .front
}

extension CardSide {
  init(_ cardSideDB: CardSideDB?) {
    if let cardSideDB = cardSideDB {
      self.id = cardSideDB.id
      self.text = cardSideDB.text
      self.side = cardSideDB.side
    }
  }
}

extension Array where Iterator.Element == Card {
  var hasSelectedItems: Bool {
    return self.contains { $0.selected }
  }
  
//  var allCardsReviewed: Bool {
//    return self.allSatisfy { $0.reviewed }
//  }
//
//  var answersCorrect: Int {
//    return self.filter { $0.answerCorrect }.count
//  }
//
//  var answersWrong: Int {
//    return self.filter { !$0.answerCorrect }.count
//  }
}


