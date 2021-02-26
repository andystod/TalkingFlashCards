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
  
//  @State var deck = Deck()
  
  var body: some View {
    
    List(){
      NavigationLink(destination: NewDeckView()) {
        Text("Add New Deck")
          .foregroundColor(.accentColor)
      }
      ForEach(viewModel.decks.indices, id: \.self) { i in
        NavigationLink(
          destination: NewCardView(deck: $viewModel.decks[i])) { // TODO
          Text(viewModel.decks[i].name)
        }
      }
    }
    .alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
      Alert(title: Text("Error"))
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
    @Published var error: Error?
    
    @Dependency var deckDataService: DeckDataService
    private var cancellables = Set<AnyCancellable>()
    
    func getDecks() {
      
      deckDataService.getDecks()
        .sink { completion in
          
          if case let .failure(error) = completion {
            print(error)
          }
          
          
          switch completion {
          case .finished: break
          case let .failure(error):
            print(error)
          }
        } receiveValue: { [weak self] decks in
          self?.decks = decks
          print(self?.decks.indices)
        }
        .store(in: &cancellables)
      
      
      
      
    }
  }
}


struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    let decks = [Deck(name: "Deck1"),
                 Deck(name: "Deck2"),
                 Deck(name: "Deck4")]
    let viewModel = AddView.ViewModel()
    viewModel.decks = decks
    return NavigationView {
      AddView(viewModel: viewModel)
    }
  }
}
