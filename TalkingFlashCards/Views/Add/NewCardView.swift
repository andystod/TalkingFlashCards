//
//  NewCardView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI
import Combine

// TODO need to make keyboard change depending on language

struct NewCardView: View {
  
  var deck: Deck
  @Environment(\.presentationMode) var presentationMode
  @StateObject var viewModel: ViewModel
  @State var front = ""
  @State var back = ""
  
  init(viewModel: ViewModel = .init(), deck: Deck) {
    _viewModel = StateObject(wrappedValue: viewModel)
    self.deck = deck
  }
  
  var body: some View {
    //    NavigationView {
    Form {
      Section(header: Text("Front")) {
        // TODO should change default keyboard
        TextEditor(text: $front)
          .frame(minHeight: 70.0, maxHeight: 150.0)
        //          .foregroundColor(.secondary)
      }
      Section(header: Text("Back")) {
        TextEditor(text: $back)
          .frame(minHeight: 70.0, maxHeight: 150.0)
        //          .foregroundColor(.secondary)
      }
    }
    .navigationTitle("New Card")
    .toolbar {
      ToolbarItem(placement: .confirmationAction) {
        Button("Save") {
          viewModel.addCard(Card(front: CardSide(text: front), back: CardSide(text: back)), to: deck)
        }
      }
      ToolbarItem(placement: .cancellationAction) {
        Button("Done") {
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
            resetScreen()
          case .failure(let error):
            break
          case .none:
            break
          }
        }
        .store(in: &self.viewModel.cancellables)
    }
  }
  
  func resetScreen() {
    front = ""
    back = ""
  }
  
}

extension NewCardView {
  class ViewModel: ObservableObject {
    
    @Published var result: Result<Void, Error>?
//    @Dependency var deckDataService: DeckDataService
    var cancellables = Set<AnyCancellable>()
    
    func addCard(_ card: Card, to deck: Deck) {
//      deckDataService.addCard(card, to: deck)
//        .sink { [weak self] completion in
//          if case let .failure(error) = completion {
//            self?.result = .failure(error)
//          } else {
////            deck.cards.append(card) // TODO this needs to go
//            self?.result = .success(())
//          }
//        } receiveValue: { _ in }
//        .store(in: &cancellables)
    }
  }
}

struct NewCardView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NewCardView(deck: Deck())
        .preferredColorScheme(.dark)
    }
  }
}
