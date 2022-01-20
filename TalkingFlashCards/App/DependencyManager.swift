//
//  DependencyManager.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import Foundation

class DependencyManager {
    
    static func addDependencies() {
      DependencyContainer.register(DeckDataService() as DeckDataServiceProtocol)
      DependencyContainer.register(CardDataService() as CardDataServiceProtocol)
      DependencyContainer.register(LanguageService() as LanguageServiceProtocol)
    }
}
