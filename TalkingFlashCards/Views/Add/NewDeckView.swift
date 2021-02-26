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
  @State var alertItem: AlertItem?
  @State var proceedToNewCard = false
  @State var saveAndAddCardsPressed = false
  
  init(viewModel: ViewModel = .init()) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  
  var body: some View {
    Form {
      Section {
        TextField("Deck Name *", text: $deck.name)
        TextField("Deck Description", text: $deck.description)
      }
      SideSettingsView(sectionName:"Front Side Settings", sideSettings: $deck.frontSideSettings)
      SideSettingsView(sectionName:"Back Side Settings", sideSettings: $deck.backSideSettings)
      Section {
        
        // TODO Test adding this button outside the form
        
        Button(action: {
                saveAndAddCardsPressed = true
                viewModel.createDeck(deck) }) {
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
    .navigationTitle("New Deck")
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button(action: { viewModel.createDeck(deck) }) {
          Text("Save")
            .fontWeight(.black)
          
        }
        .disabled(!deck.hasRequiredFieldsFilled)
      }
      
      ToolbarItem(placement: .cancellationAction) {
        Button("Cancel") {
          presentationMode.wrappedValue.dismiss()
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    .onAppear {
      viewModel.$result
        .sink { value in
          switch value {
          case .success():
            // Depending on save button pressed either proceed to add cards or return to previous screen
            if saveAndAddCardsPressed {
              proceedToNewCard = true
            } else {
              presentationMode.wrappedValue.dismiss()
            }
          case .failure(let error):
            saveAndAddCardsPressed = false
            print(error)
            alertItem = AlertItem(id: UUID(), title: Text("Error Occured"), message: Text(error.localizedDescription), dismissButton: Alert.Button.default(Text("OK")))
          case .none:
            break
          }
        }
        .store(in: &self.viewModel.cancellables)
    }
    NavigationLink(
      destination: NewCardView(deck: $deck),
      isActive: $proceedToNewCard) { EmptyView() }
  }
}

extension NewDeckView {
  class ViewModel: ObservableObject {
    
    @Published var result: Result<Void, Error>? //.success(false)
    
    //    @Published var error: Error?
    @Dependency var deckDataService: DeckDataService
    var cancellables = Set<AnyCancellable>()
    
    func createDeck(_ deck: Deck) {
      //      result = nil
      deckDataService.createDeck(deck: deck)
        .sink { completion in
          if case let .failure(error) = completion {
            self.result = .failure(error)
          } else {
            self.result = .success(())
          }
          print(completion)
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
  }
}

struct SideSettingsView: View {
  
  var sectionName: String
  
  // TODO these need to be loaded into environment or some kind of cache
  @Dependency var languageService: LanguageService
  
  @Binding var sideSettings: SideSettings
  
  var body: some View {
    Section(header: Text(sectionName)) {
      Picker("Language *", selection: $sideSettings.language) {
        Text("N/A").tag("N/A")
          .navigationTitle("Select Language")
        ForEach(languageService.getUniqueLanguages(), id:\.self) {
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
      NewDeckView()
    }
    .preferredColorScheme(.dark)
  }
}
