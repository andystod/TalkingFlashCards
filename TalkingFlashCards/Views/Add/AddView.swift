//
//  AddView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI
import Combine

struct AddView: View {
  
  @EnvironmentObject var deckStore: DeckStore
  
  var body: some View {
    
    VStack {
      List {
        NavigationLink(destination: NavigationLazyView( NewDeckView(mode: .create))) {
          Label("Add New Deck", systemImage:"plus.rectangle.on.rectangle")
            .foregroundColor(.accentColor)
        }
        ForEach(deckStore.decks.indices, id: \.self) { i in
          NavigationLink(
            destination: ManageDeckView(deckId: deckStore.decks[i].id)) { // TODO
            Label(deckStore.decks[i].name, systemImage:"square.and.pencil")
          }
        }
        .onDelete(perform: { indexSet in
          print("delete")
        })
      }
    }
    .navigationTitle("Add New Card")
  }
}

struct ContentView3: View {
  @Binding var shouldPopToRootView : Bool
  
  var body: some View {
    VStack {
      Text("Hello, World #3!")
      Button (action: { self.shouldPopToRootView = false } ){
        Text("Pop to root")
      }
    }.navigationBarTitle("Three")
  }
}


extension AddView {
  class ViewModel: ObservableObject {
    @Published var decks: [Deck]
    @Published var error: Error?
    var deckStore: DeckStore
    
    init(deckStore: DeckStore) {
      self.deckStore = deckStore
      self.decks = deckStore.decks
    }
    
  }
}


struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    let deckStore = DeckStore()
    deckStore.decks = [Deck(name: "Deck1"),
                       Deck(name: "Deck2"),
                       Deck(name: "Deck4")]
    return NavigationView {
      AddView()
        .environmentObject(deckStore)
    }
  }
}
