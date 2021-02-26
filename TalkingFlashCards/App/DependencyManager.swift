//
//  DependencyManager.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import Foundation

class DependencyManager {
    
    static func addDependencies() {
      DependencyContainer.register(RealmDeckDataService() as DeckDataService)
      DependencyContainer.register(LocalLanguageService() as LanguageService)
    }
}
