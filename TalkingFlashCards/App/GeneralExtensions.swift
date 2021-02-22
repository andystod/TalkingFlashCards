//
//  GeneralExtensions.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 17/02/2021.
//

import Foundation

extension Result {
    var isSuccess: Bool { if case .success = self { return true } else { return false } }

    var isError: Bool {  return !isSuccess  }
}
