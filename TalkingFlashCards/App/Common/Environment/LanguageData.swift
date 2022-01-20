//
//  LanguageData.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 01/03/2021.
//

import Foundation

class LanguageData: ObservableObject {
  
  @Published var uniqueLanguages: [Language]
//  @Dependency private(set) var languageService: LanguageService TODO
  
  init(languageService: LanguageServiceProtocol = LanguageService()) {
    uniqueLanguages = languageService.getUniqueLanguages()
  }
  
}
