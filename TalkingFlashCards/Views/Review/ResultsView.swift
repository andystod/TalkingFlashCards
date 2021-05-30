//
//  ResultsView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 09/05/2021.
//

import SwiftUI

struct ResultsView: View {
  
  @ObservedObject var cardStore: CardStore
  @State var labels = ["Right", "Wrong"]
  
  var body: some View {
    VStack {
      Text("Results")
        .font(.title3)
        .foregroundColor(.accentColor)
        .padding()
      PieChart(data: [Double(cardStore.answersCorrect), Double(cardStore.answersWrong)], labels: labels, colors: [.green, .red], borderColor: .white)
        .frame(width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.width - 10)
      VStack {
        Text("Number of Cards Reviewed: \(cardStore.cards.count)")
        Text("Number of Cards Correct: \(cardStore.answersCorrect)")
        Text("Number of Cards Incorrect: \(cardStore.answersWrong)")
      }
      .padding()
      Spacer()
    }
  }
}

struct ResultsView_Previews: PreviewProvider {
  static var previews: some View {
    let cardStore = CardStore(cards: [Card](repeating: Card.example, count: 5))
    cardStore.answersCorrect = 3
    cardStore.answersWrong = 2
    return ResultsView(cardStore: cardStore)
  }
}
