//
//  VoiceSettingsView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 24/02/2021.
//

import SwiftUI
import Combine

struct VoiceSettingsView: View {
  
  //  @Dependency var languageService: LanguageService TODO
  @StateObject var viewModel: ViewModel
  
  init(viewModel: ViewModel = ViewModel()) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    List(viewModel.languagesAndVoices, id: \.self) { languageAndVoice in
      NavigationLink(
        destination: VoiceSelectionView(language: languageAndVoice.language, selectedVoice: languageAndVoice.voice)) {
        
        HStack {
          Image(systemName: "wave.3.right")
            .foregroundColor(.yellow)
          Text(languageAndVoice.language.displayValue)
          Spacer()
          Text(!languageAndVoice.voice.defaultItem ? "\(languageAndVoice.voice.name) (\(languageAndVoice.voice.languageAndRegionCode))" : "Default") // TODO remove
        }
      }
    }
    .navigationTitle("Voice Settings")
    .onAppear {
      print(viewModel)
      print(viewModel.cancellable)
    }
  }
}

extension VoiceSettingsView {
  class ViewModel: ObservableObject {
    
    @Published var languagesAndVoices = [LanguageAndVoice]()
    var cancellable: AnyCancellable?
    
    init() {
      
      
      cancellable = UserDefaults.standard.publisher(for: \.voicePreferences)
        .sink { [weak self] voicePreferences in
          
          let languages = GlobalData.shared.languageData.uniqueLanguages
          self?.languagesAndVoices = languages.map { LanguageAndVoice(language: $0, voice: voicePreferences[$0.languageCode] != nil ? Voice(identifier:  voicePreferences[$0.languageCode] as! String) : Voice(defaultItem: true)) }
        }
      
      
      
      //      let savedVoices = UserDefaults.standard.dictionary(forKey: UserDefaults.Keys.voices) ?? [String:String]()
      //
      //      let languages = GlobalData.shared.languageData.uniqueLanguages
      //      languagesAndVoices = languages.map { LanguageAndVoice(language: $0, voice: savedVoices[$0.languageCode] != nil ? Voice(identifier:  savedVoices[$0.languageCode] as! String) : Voice(defaultItem: true)) }
    }
    
  }
  
  struct LanguageAndVoice: Hashable {
    let language: Language
    let voice: Voice // TODO change to voice object - need to save id and load object from that
  }
  
}


struct VoiceSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      //      var viewModel = VoiceSettingsView.ViewModel()
      //      viewModel.
      VoiceSettingsView()
      
    }
  }
}
