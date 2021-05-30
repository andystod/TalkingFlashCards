//
//  NewCardView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI
import Combine

// TODO make keyboard change depending on language
struct NewCardView: View {
  
  @State var card: Card
  @ObservedObject var cardStore: CardStore
  @Environment(\.presentationMode) var presentationMode
  var mode: CrudMode
  var viewModel: ViewModel
  
  init(card: Card = Card(), cardStore: CardStore, mode: CrudMode, viewModel: ViewModel = ViewModel()) {
    self._card = State(wrappedValue: card)
    self.cardStore = cardStore
    self.mode = mode
    self.viewModel = viewModel
  }
  
  var body: some View {
    Form {
      Section(header: Text("Front")) {
        TextEditor(text: $card.front.text)
          .introspectTextView { textField in
            if self.viewModel.frontTextView == nil {
              self.viewModel.frontTextView = textField
              if card.front.text.isEmpty && card.back.text.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  viewModel.frontTextView?.becomeFirstResponder()
                }
              }
            }
          }
          .frame(minHeight: 70.0, maxHeight: 150.0)
      }
      Section(header: Text("Back")) {
        TextEditor(text: $card.back.text)
          .frame(minHeight: 70.0, maxHeight: 150.0)
      }
    }
    .navigationTitle(mode == .create ? "New Card" : "Edit Card")
    .toolbar {
      ToolbarItem(placement: .confirmationAction) {
        Button("Save") {
          if mode == .create {
            cardStore.addCard(card)
            resetScreen()
          } else {
            cardStore.updateCard(card)
          }
        }
        .disabled(hasEmptyFields())
      }
      ToolbarItem(placement: .cancellationAction) {
        Button("Done") {
          presentationMode.wrappedValue.dismiss()
        }
      }
    }
    .navigationBarBackButtonHidden(true)
  }
  
  func resetScreen() {
    card = Card()
    viewModel.frontTextView?.becomeFirstResponder()
  }
  
  func hasEmptyFields() -> Bool {
    card.front.text.isEmpty || card.back.text.isEmpty
  }
  
}

extension NewCardView {
  class ViewModel {
    var frontTextView: UITextView?
  }
}

struct NewCardView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NewCardView(card: Card(front: CardSide(text: "Front text"), back: CardSide(text: "Back text")),
                  cardStore: CardStore(),
                  mode: .edit)
        .preferredColorScheme(.dark)
    }
  }
}
