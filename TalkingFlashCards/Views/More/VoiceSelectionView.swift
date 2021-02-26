//
//  VoiceSelectionView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 25/02/2021.
//

import SwiftUI

struct VoiceSelectionView: View {
  
  var languageCode: String
  @StateObject var viewModel: ViewModel
  @Dependency var languageService: LanguageService
  
  init(viewModel: ViewModel = ViewModel(), languageCode: String) {
    self._viewModel = StateObject(wrappedValue: viewModel)
    self.languageCode = languageCode
  }
  
  var body: some View {
    List {
      Text("Select Voice")
    }
    .navigationTitle("Select Voice")
  }
}

extension VoiceSelectionView {
  class ViewModel: ObservableObject {
    
  }
}

struct VoiceSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VoiceSelectionView(languageCode: "en")
    }
  }
}
