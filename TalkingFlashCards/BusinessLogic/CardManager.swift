//
//  CardManager.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 08/04/2021.
//

import Foundation


enum BoxNumber: Int {
  case min = 0
  case max = 5
}

let boxNumberOfDays = [1, 2, 4, 8, 16, 32]

class CardManager {
  
  func promoteCard(_ card: inout Card) {
    if card.boxNumber < BoxNumber.max.rawValue {
      card.boxNumber += 1
    }
    card.nextReviewDate = getNextReviewDate(card: card)
//    card.reviewed = true
  }
  
  func demoteCard(_ card: inout Card) {
    if card.boxNumber > BoxNumber.min.rawValue {
      card.boxNumber -= 1
    }
    card.nextReviewDate = getNextReviewDate(card: card)
//    card.reviewed = true
  }
  
  private func getNextReviewDate(card: Card) -> Date {
    return Calendar.current.date(byAdding: .day, value: boxNumberOfDays[card.boxNumber], to: Date())!
  }
  
  
}
