//
//  VoiceSettingsView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 24/02/2021.
//

import SwiftUI

struct VoiceSettingsView: View {
  
  @Dependency var languageService: LanguageService
  
  var body: some View {
    List(languageService.getUniqueLanguages(), id: \.self) { language in
      NavigationLink(
        destination: VoiceSelectionView(languageCode: "en")) {
        
        HStack {
          Image(systemName: "wave.3.right")
            .foregroundColor(.yellow)
          Text(language.displayValue)
        }
      }
    }
    .navigationTitle("Voice Settings")
  }
}

struct VoiceSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VoiceSettingsView()
    }
  }
}
