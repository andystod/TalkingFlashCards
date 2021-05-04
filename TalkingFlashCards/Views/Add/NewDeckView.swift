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
  @EnvironmentObject var deckStore: DeckStore
  @State var deck: Deck = Deck()
  var mode: CrudMode
  @State var alertItem: AlertItem?
  @State var proceedToNewCard = false
  @State var deckId: String
  @State private var cancelButtonText = "Cancel"
  
  init(deckId: String = "", mode: CrudMode) {
    self._deckId = State(wrappedValue: deckId)
    self.mode = mode
  }
  
  
  var body: some View {
    Form {
      Section {
        TextField("Deck Name *", text: $deck.name)
        TextField("Deck Description", text: $deck.desc)
      }
      SideSettingsView(sectionName:"Front Side Settings", sideSettings: $deck.frontSideSettings)
      SideSettingsView(sectionName:"Back Side Settings", sideSettings: $deck.backSideSettings)
      Section {
        
        // TODO Test adding this button outside the form
        
        Button(action: {
          if mode == .create {
            deckStore.createDeck(deck)
          } else {
            deckStore.updateDeck(deck)
          }
          proceedToNewCard = true
          cancelButtonText = "Done"
        }) {
          Text("Save and Add Cards")
            .bold()
          
        }
        .disabled(!deck.hasRequiredFieldsFilled)
      }
      .alert(item: $alertItem) { alertItem in
        guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else{
          return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
      }
    }
    .navigationTitle(mode == .create ? "New Deck" : "Edit Deck")
    .onAppear {
      if !deckId.isEmpty {
        self.deck = deckStore.deckById(deckId)
        deckId = ""
      }
    }
    .toolbar {
      ToolbarItem(placement: .confirmationAction) {
        Button(action: {
          if mode == .create {
            deckStore.createDeck(deck)
          } else {
            deckStore.updateDeck(deck)
          }
          presentationMode.wrappedValue.dismiss()
        }) {
          Text("Save")
            .fontWeight(.black)
          
        }
        .disabled(!deck.hasRequiredFieldsFilled)
      }
      
      ToolbarItem(placement: .cancellationAction) {
        Button(cancelButtonText) {
          presentationMode.wrappedValue.dismiss()
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    NavigationLink(
      destination: NewCardView(cardStore: deck.cardStore, mode: .create),
      isActive: $proceedToNewCard) { EmptyView() }
  }
}

struct SideSettingsView: View {
  
  var sectionName: String
  
  @Binding var sideSettings: SideSettings
  var uniqueLanguages = GlobalData.shared.languageData.uniqueLanguages
  
  var body: some View {
    Section(header: Text(sectionName)) {
      Picker("Language *", selection: $sideSettings.languageCode) {
        Text("N/A").tag("N/A")
          .navigationTitle("Select Language")
        ForEach(uniqueLanguages, id: \.languageCode) {
          Text($0.displayValue)
        }
      }
      Toggle("Auto Play Text", isOn: $sideSettings.autoPlay)
    }
  }
}

struct NewDeckView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NewDeckView(mode: .edit)
    }
    .preferredColorScheme(.dark)
  }
}


struct ItemsPerPageKey: EnvironmentKey {
  static var defaultValue: Int = 10
}

extension EnvironmentValues {
  var itemsPerPage: Int {
    get { self[ItemsPerPageKey.self] }
    set { self[ItemsPerPageKey.self] = newValue }
  }
}
