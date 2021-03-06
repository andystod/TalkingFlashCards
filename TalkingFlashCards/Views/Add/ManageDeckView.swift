//
//  EditSelectionView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 04/03/2021.
//

import SwiftUI
import Introspect



struct ManageDeckView: View {
  
  @EnvironmentObject var deckStore: DeckStore
  @StateObject private var viewModel: ViewModel = ViewModel()
  @State var deck: Deck = Deck()
  var deckId: String
  
  init(deckId: String) {
    self.deckId = deckId
  }
  
  
  var body: some View {
    List {
      NavigationLink(
        destination: NavigationLazyView(NewDeckView(deckId: deck.id, mode: .edit))) {
        HStack {
          Image(systemName: "pencil")
            .font(Font.body.weight(.bold))
            .foregroundColor(.yellow)
          
          Text("Edit Deck")
        }
      }
      NavigationLink(
        destination: NavigationLazyView(NewCardView(cardStore: deck.cardStore, mode: .create))) {
        HStack {
          Image(systemName: "plus")
            .font(Font.body.weight(.bold))
            .foregroundColor(.yellow)
          Text("Add Cards")
        }
      }
      NavigationLink(
        destination: ManageCardsView(cardStore: deck.cardStore))
      {
        HStack {
          Image(systemName: "rectangle.grid.2x2")
            .font(Font.body.weight(.semibold))
            .foregroundColor(.yellow)
          Text("Manage Cards")
        }
      }
    }
    .introspectTableView { tableView in
      self.viewModel.bindToTableView(tableView)
    }
    .onAppear(perform: {
      self.viewModel.clearTableViewSelection()
      self.deck = deckStore.deckById(deckId)
    })
    .onDisappear(perform: {
      self.viewModel.clearTableViewSelection()
    })
    .navigationTitle(deck.name)
  }
}

extension ManageDeckView {
  class ViewModel: ObservableObject {
    //    @Published var deck: Deck
    private var tableView: UITableView? // for bug workaround
    
    //    init(deck: Deck) {
    //      self.deck = deck
    //    }
    
    func bindToTableView(_ tableView: UITableView) {
      self.tableView = tableView
    }
    
    func clearTableViewSelection() {
      // This is a iOS14 hack that prevents clicked cell background view to remain highlighted when we come back to the screen
      if #available(iOS 14, *){
        DispatchQueue.main.async {
          if let selectedIndexPath = self.tableView?.indexPathForSelectedRow {
            self.tableView?.deselectRow(at: selectedIndexPath, animated: false)
            if let selectedCell = self.tableView?.cellForRow(at: selectedIndexPath) {
              selectedCell.setSelected(false, animated: false)
            }
            
          }
        }
      }
    }
  }
}


struct ManageDeckView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ManageDeckView(deckId: "123")
        .environmentObject(DeckStore(callLoad: false))
    }
  }
}
