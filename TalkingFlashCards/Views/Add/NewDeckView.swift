//
//  NewDeckView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI
import Combine

struct NewDeckView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @StateObject var viewModel: ViewModel
  @State var deck: Deck = Deck()
  
  init(viewModel: ViewModel = .init()) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  
  var body: some View {
    Form {
      Section {
        TextField("Deck Name (required)", text: $deck.name)
        TextField("Deck Description", text: $deck.description)
      }
      SideSettingsView(sectionName:"Front Side Settings", sideSettings: $deck.frontSideSettings)
      SideSettingsView(sectionName:"Back Side Settings", sideSettings: $deck.backSideSettings)
      Section {
        Button("Save") {
          let _ = print("language:", deck.frontSideSettings.language)
        }
      }
    }
    .navigationTitle("New Deck")
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button("Save") {
          viewModel.createDeck(deck)
          presentationMode.wrappedValue.dismiss()
        }
        .foregroundColor(.green)
      }
      ToolbarItem(placement: .cancellationAction) {
        Button("Cancel") {
          presentationMode.wrappedValue.dismiss()
        }
      }
    }
    .navigationBarBackButtonHidden(true)
  }
}

extension NewDeckView {
  class ViewModel: ObservableObject {
    
    @Dependency var deckDataService: DeckDataService
    private var cancellables = Set<AnyCancellable>()
    
    func createDeck(_ deck: Deck) {
      deckDataService.createDeck(deck: deck)
        .sink { completion in
          print(completion)
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
  }
}

struct SideSettingsView: View {
  
  var sectionName: String
  var languages = ["English", "Spanish", "German"]
  @Binding var sideSettings: SideSettings
  
  var body: some View {
    Section(header: Text(sectionName)) {
      Picker("Language", selection: $sideSettings.language) {
        Text("N/A").tag("N/A")
        ForEach(languages, id:\.self) {
          Text($0)
        }
      }
      Toggle("Auto Play Text", isOn: $sideSettings.autoPlay)
    }
  }
}

struct NewDeckView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NewDeckView()
    }
    .preferredColorScheme(.dark)
  }
}
