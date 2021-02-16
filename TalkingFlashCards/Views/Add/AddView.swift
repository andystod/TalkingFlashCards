//
//  AddView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI
import Combine

struct AddView: View {
  
  @StateObject var viewModel: ViewModel
  init(viewModel: ViewModel = .init()) {
    
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    
    List(){
      NavigationLink(destination: NewDeckView()) {
        Text("Add New Deck")
          .foregroundColor(.accentColor)
      }
      ForEach(viewModel.decks) { deck in
        NavigationLink(
          destination: NewCardView()) {
          Text(deck.name)
        }
      }
    }
    .navigationTitle("AddTabTitle")
    .onAppear(perform: {
      viewModel.getDecks()
    })
    
  }
}

extension AddView {
  class ViewModel: ObservableObject {
    @Published var decks = [Deck]()
    
    @Dependency var deckDataService: DeckDataService
    var cancellables = Set<AnyCancellable>()
    
    func getDecks() {
      
      deckDataService.getDecks().sink { completion in
        
        if case let .failure(error) = completion {
          print(error)
        }
        
        
        switch completion {
        case .finished: break
        case let .failure(error):
          print(error)
        }
      } receiveValue: { [weak self] value in
        self?.decks = value
      }
      .store(in: &cancellables)
      
      
      
      
    }
  }
}

struct Deck: Identifiable {
  var id: UUID
  var name: String
}

struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    let decks = [Deck(id: UUID(), name: "Deck1"),
                 Deck(id: UUID(), name: "Deck2"),
                 Deck(id: UUID(), name: "Deck4")]
    let viewModel = AddView.ViewModel()
    viewModel.decks = decks
    return NavigationView {
      AddView(viewModel: viewModel)
    }
  }
}
