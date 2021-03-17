//
//  ReviewView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 19/02/2021.
//

import SwiftUI
import Combine

struct ReviewView: View {
  
  @EnvironmentObject var deckStore: DeckStore
  
  var body: some View {
    VStack {
      List(deckStore.decks) { deck in
        NavigationLink(destination: ReviewCardsView(deck: deck)) {
          HStack {
            Image(systemName: "book.fill")
            Text(deck.name) }
        }
      }
      .foregroundColor(.yellow)
    }
    .navigationTitle("Review")
  }
}

struct ReviewView_Previews: PreviewProvider {
  static var previews: some View {
    return NavigationView {
      ReviewView()
        .environmentObject(DeckStore(decks: [Deck(name: "Deck 1")]))
        .preferredColorScheme(.dark)
    }
  }
}
