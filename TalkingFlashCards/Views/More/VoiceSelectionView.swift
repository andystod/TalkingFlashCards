//
//  VoiceSelectionView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 25/02/2021.
//

import SwiftUI
import AVFoundation

struct VoiceSelectionView: View {
  
  var language: Language
  @StateObject var viewModel: ViewModel
  @Dependency var languageService: LanguageService
  @State private var selectedItem: AVSpeechSynthesisVoice?
  
  init(viewModel: ViewModel = ViewModel(), language: Language) {
    self._viewModel = StateObject(wrappedValue: viewModel)
    self.language = language
  }
  
  var body: some View {
    VStack {
      Text("Select a Voice to override the default selection")
      List(selection: $selectedItem) {
        ForEach(viewModel.voices, id: \.self) { voice in
          Text("\(voice.languageAndRegionDescription) - \(voice.name)")
        }
      }
      .environment(\.editMode, .constant(EditMode.active))
    }
    .navigationTitle(
      Text("Select \(language.displayValue) Voice")
    )
    
    .onAppear {
      viewModel.loadLanguages(languageCode: language.languageCode)
    }
  }
}

extension VoiceSelectionView {
  class ViewModel: ObservableObject {
    @Published var voices = [AVSpeechSynthesisVoice]()
    @Dependency var languageService: LanguageService
    
    func loadLanguages(languageCode: String) {
      voices = languageService.getVoicesForLanguage(languageCode)
    }
    
  }
}

struct VoiceSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    
    let viewModel = VoiceSelectionView.ViewModel()
    //    viewModel.voices = ["Moira", "Dave", "Shane"]
    
    return NavigationView {
      VoiceSelectionView(viewModel: viewModel, language: Language(languageAndRegionCode: "en-GB"))
    }
  }
}
