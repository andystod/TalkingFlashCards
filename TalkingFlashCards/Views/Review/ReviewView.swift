//
//  ReviewView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 19/02/2021.
//

import SwiftUI
import Combine

struct ReviewView: View {
  
  @StateObject private var viewModel: ViewModel
  @State var decks = [Deck]()
  
//  var deck = Deck(frontSideSettings: SideSettings(side: .front, language: "en-GB"), backSideSettings: SideSettings(side: .back, language: "es-MX"))
  
  init(viewModel: ViewModel = ViewModel()) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    VStack {
      List(decks) { deck in
        NavigationLink(destination: ReviewCardsView(deck: deck)) {
          HStack {
            Image(systemName: "book.fill")
            Text(deck.name) }
        }
      }
      .foregroundColor(.yellow)
    }
    .navigationTitle("Review")
    .onAppear {
//      viewModel.loadDecks()
//      viewModel.$result
//        .sink { result in
//          switch result {
//
//          case .success(let decks):
//            self.decks = decks
//          case .failure(let error):
//            break
//          case .none:
//            break
//          }
//        }
//        .store(in: &viewModel.cancellables)
    }
  }
}

extension ReviewView {
  class ViewModel: ObservableObject {
    
    @Published var result: Result<[Deck], Error>?
//    @Dependency var deckDataService: DeckDataService
    var cancellables = Set<AnyCancellable>()
    
    func loadDecks() {
      // TODO
//      deckDataService.loadDecks()
//        .sink { [weak self] completion in
//          if case let .failure(error) = completion {
//            self?.result = .failure(error)
//          }
//        } receiveValue: { [weak self] decks in
//          self?.result = .success(decks)
//        }
//        .store(in: &cancellables)
    }
    
  }
}

struct ReviewView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = ReviewView.ViewModel()
    viewModel.result = .success([Deck(name: "Deck 1")])
    
    return NavigationView {
      ReviewView(viewModel: viewModel)
        .preferredColorScheme(.dark)
    }
  }
}
