//
//  ManageCardsView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 04/03/2021.
//

import SwiftUI

struct ManageCardsView: View {
  
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @State var editMode: EditMode = .inactive
  @State var showAlert = false
  @ObservedObject var cardStore: CardStore
  
  init(cardStore: CardStore) {
    self.cardStore = cardStore
    UIToolbar.appearance().tintColor = UIColor(Color.red)
  }
  
  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: getGridItems(), spacing: 10.0, content: {
        ForEach(cardStore.cards) { card in
          CollageCardItemView(cardIndex: cardStore.cards.firstIndex(of:card)!,
                              cardStore: cardStore,
                              editMode: $editMode)
        }
      })
      .padding()
      .conditionalModifier(editMode == .inactive, ifTrue: {
        $0.toolbar{
          ToolbarItem {
            EditButton()
          }
        }
      }, ifFalse: {
        $0.toolbar{
          ToolbarItem {
            EditButton()
          }
          ToolbarItem(placement: .bottomBar) {
            Spacer()
          }
          ToolbarItem(placement: .bottomBar) {
            Text("Select Items")
              .bold()
          }
          ToolbarItem(placement: .bottomBar) {
            Spacer()
          }
          ToolbarItem(placement: .bottomBar) {
            Button(action: {
              showAlert = true
            }) {
              Image(systemName: "trash")
            }
            .disabled(!cardStore.cards.hasSelectedItems)
          }
        }
      })
      
    }
    .navigationTitle("Manage Cards")
    .environment(\.editMode, $editMode)
    .alert(isPresented: $showAlert) {
      Alert(title: Text("Delete Cards?"), message: Text("This cannot be undone"), primaryButton: .destructive(Text("Delete"), action: {
        print("Delete")
        cardStore.deleteCards()
      }), secondaryButton: .cancel())
    }
  }
  
  func getGridItems() -> [GridItem] {
    if horizontalSizeClass == .compact {
      return [GridItem(.flexible(minimum: 100, maximum: 200)),
              GridItem(.flexible(minimum: 100, maximum: 200)),
              GridItem(.flexible(minimum: 100, maximum: 200))]
    } else {
      return [GridItem(.flexible(minimum: 100, maximum: 300)),
              GridItem(.flexible(minimum: 100, maximum: 300)),
              GridItem(.flexible(minimum: 100, maximum: 300)),
              GridItem(.flexible(minimum: 100, maximum: 300)),
              GridItem(.flexible(minimum: 100, maximum: 300))]
    }
  }
  
}

struct CollageCardItemView: View {
  @Binding var card: Card // TODO
  //  var cardIndex: Int
  @ObservedObject var cardStore: CardStore
  @State var selectedForDelete: Bool = false
  @Binding var editMode: EditMode
  @State var tappedForEdit: Bool = false
  
  init(cardIndex: Int, cardStore: CardStore, editMode: Binding<EditMode>) {
    self._card = Binding<Card>(
      get: {
        if (cardStore.cards.count > cardIndex) {
          return cardStore.cards[cardIndex]
        } else {
          return Card()
        }
      },
      set: { cardStore.cards[cardIndex] = $0 })
    self._cardStore = ObservedObject(wrappedValue: cardStore)
    self._editMode = editMode
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 5.0)
        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
      
      Text(card.front.text)
        .foregroundColor(.yellow)
        .bold()
        .padding(.horizontal, 5.0) // TODO test
      if editMode.isEditing && selectedForDelete {
        VStack {
          Spacer()
          HStack {
            Spacer()
            Image(systemName: "checkmark.circle")
              .foregroundColor(.white)
              .background(Color.red)
              .clipShape(Circle())
              .font(.title3)
              .padding(5)
          }
        }
      }
      NavigationLink(destination: NavigationLazyView(NewCardView(card: card, cardStore: cardStore, mode: .edit))
                      .environmentObject(cardStore),
                     isActive: $tappedForEdit) {
        EmptyView()
      }
    }
    .aspectRatio(2/3, contentMode: .fill)
    .onTapGesture {
      if !editMode.isEditing {
        tappedForEdit = true
      } else {
        card.selected.toggle() // TODO
        selectedForDelete = card.selected
      }
    }
  }
  
  
}

extension ManageCardsView {
  class ViewModel: ObservableObject {
    @Published var deck: Deck
    
    init(deck: Deck) {
      self.deck = deck
    }
  }
}

struct ManageCardsView_Previews: PreviewProvider {
  static var previews: some View {
    //      UIElementPreview(
    
    NavigationView {
      ManageCardsView(cardStore: CardStore())
        .preferredColorScheme(.dark)
        .environmentObject(CardStore(cards: [Card](repeating: Card.example, count: 1)))
    }
    .navigationViewStyle(StackNavigationViewStyle())
    //      )
  }
}
