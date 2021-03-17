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
  @State var selectedVoice: Voice?
  @StateObject var viewModel: ViewModel
  @Dependency var languageService: LanguageService
  
  init(viewModel: ViewModel = ViewModel(), language: Language, selectedVoice: Voice) {
    self._viewModel = StateObject(wrappedValue: viewModel)
    self.language = language
    self._selectedVoice = State(wrappedValue: selectedVoice)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Select a Voice to override the default selection")
        .padding(.leading)
      List(selection: $selectedVoice) {
        ForEach(viewModel.voices, id: \.self) { voice in
          HStack(spacing: 0) {
            Text("\(voice.languageAndRegionDescription)")
            if !voice.defaultItem {
              Text(" - \(voice.name)")
            }
          }
        }
      }
      .onChange(of: selectedVoice, perform: { voice in
        if let voice = voice {
          var voices = UserDefaults.standard.voicePreferences
          voices[language.languageCode] = voice.identifier
          UserDefaults.standard.voicePreferences = voices
          print(UserDefaults.standard.voicePreferences) // TODO
        }
      })
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
    @Published var voices = [Voice]()
    @Dependency var languageService: LanguageService
    @Published var selectedVoice: Voice?
    
    func loadLanguages(languageCode: String) {
      var tempVoices = languageService.getVoicesForLanguage(languageCode)
      let defaultItem = Voice(defaultItem: true)
      selectedVoice = defaultItem
      tempVoices.insert(defaultItem, at: 0)
      voices = tempVoices
    }
    
  }
}

struct VoiceSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    
    let viewModel = VoiceSelectionView.ViewModel()
    //    viewModel.voices = ["Moira", "Dave", "Shane"]
    
    return NavigationView {
      VoiceSelectionView(viewModel: viewModel, language: Language(languageAndRegionCode: "en-GB"), selectedVoice: Voice(defaultItem: true))
    }
  }
}
