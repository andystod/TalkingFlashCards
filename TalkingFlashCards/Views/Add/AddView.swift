////
////  AddView.swift
////  TalkingFlashCards
////
////  Created by Andrew Stoddart on 14/02/2021.
////
//
//import SwiftUI
//import Combine
//
//struct AddView: View {
//  
////  @StateObject var viewModel: ViewModel
////  @State private var loadDecksCalled = false
//  @EnvironmentObject var deckStore: DeckStore
//  
////  init(viewModel: ViewModel) {
////    self._viewModel = StateObject(wrappedValue: viewModel)
////  }
//  
//  //  @State var deck = Deck()
//  
//  var body: some View {
//    
//    VStack {
//      Text("Swipe rows left to edit and delete")
//      List(){
//        NavigationLink(destination: NavigationLazyView(NewDeckView(mode: .create))) {
//          Text("Add New Deck")
//            .foregroundColor(.accentColor)
//        }
//        ForEach(deckStore.decks.indices, id: \.self) { i in
//          NavigationLink(
//            destination: ManageDeckView(deck: deckStore.decks[i])) { // TODO
//            Text(deckStore.decks[i].name)
//          }
//        }
//        .onDelete(perform: { indexSet in
//          print("delete")
//        })
//      }
//    }
////    .alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
////      Alert(title: Text("Error"))
////    }
//    .navigationTitle("AddTabTitle")
//    .onAppear(perform: {
//      print("TODO - is this still getting called from Edit")
////      if !loadDecksCalled {
////        viewModel.loadDecks() // Move this to init - though that may not work for refreshes
////        loadDecksCalled = true // TODO - must be a better way - this get called in edit mode on first select
////      }
//    })
//    
//  }
//}
//
//extension AddView {
//  class ViewModel: ObservableObject {
//    @Published var decks: [Deck]
//    @Published var error: Error?
//    var deckStore: DeckStore
//    
//    init(deckStore: DeckStore) {
//      self.deckStore = deckStore
//      self.decks = deckStore.decks
//    }
//    
//  }
//}
//
//
//struct AddView_Previews: PreviewProvider {
//  static var previews: some View {
//    let deckStore = DeckStore()
//    deckStore.decks = [Deck(name: "Deck1"),
//                       Deck(name: "Deck2"),
//                       Deck(name: "Deck4")]
//    return NavigationView {
//      AddView()
//        .environmentObject(deckStore)
//    }
//  }
//}
