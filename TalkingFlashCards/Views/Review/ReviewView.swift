//
//  ReviewView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 19/02/2021.
//

import SwiftUI

struct ReviewView: View {
  
  var deck = Deck()
  
  var body: some View {
    VStack {
      Text("Review")
      Divider()
      NavigationLink(destination: ReviewCardsView(deck: deck)) { Text("Deck A") }
    }
    .navigationTitle("Review")
  }
}

struct ReviewView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ReviewView()
    }
  }
}
