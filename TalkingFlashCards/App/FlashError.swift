//
//  Error.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 17/02/2021.
//

import Foundation

enum FlashError: Swift.Error, CustomStringConvertible, LocalizedError {
  // 1
//  case network
//  case jokeDoesntExist(id: String)
//  case parsing
  case known
  case unknown
  
  // 2
  var description: String {
    switch self {
//    case .network:
//      return "Request to API Server failed"
//    case .parsing:
//      return "Failed parsing response from server"
//    case .jokeDoesntExist(let id):
//      return "Joke with ID \(id) doesn't exist"
    case .known:
      return "A known error occurred"
    case .unknown:
      return "An unknown error occurred"
    }
  }
  
  var errorDescription: String? { NSLocalizedString(description, comment: "") }
}

