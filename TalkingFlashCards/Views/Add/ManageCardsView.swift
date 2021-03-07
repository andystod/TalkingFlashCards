//
//  ManageCardsView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 04/03/2021.
//

import SwiftUI

struct ManageCardsView: View {
  
  
  @StateObject var viewModel: ViewModel
  @Binding var deck: Deck
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @State var editMode: EditMode = .inactive
  
  private var threeColumnGrid = [GridItem(.flexible(minimum: 100, maximum: 200)),
                                 GridItem(.flexible(minimum: 100, maximum: 200)),
                                 GridItem(.flexible(minimum: 100, maximum: 200)),
                                 GridItem(.flexible(minimum: 100, maximum: 200)),
                                 GridItem(.flexible(minimum: 100, maximum: 200))]
  
  init(viewModel: ViewModel = .init(),
       deck: Binding<Deck>) {
    _viewModel = StateObject(wrappedValue: viewModel)
    _deck = deck
    _deck = .constant(Deck(cards: [Card](repeating: Card.example, count: 300))) // TODO
    
    UIToolbar.appearance().tintColor = UIColor(Color.red)
  }
  
  
  
  var body: some View {
    
    
    
    ScrollView(.vertical) {
      LazyVGrid(columns: getGridItems(), spacing: 10.0, content: {
        ForEach(deck.cards.indices) { index in
          CollageCardItemView(card: $deck.cards[index])
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
            Button(action: {}) {
              Image(systemName: "trash")
            }
            .disabled(!editMode.isEditing) // TODO change to work on selected items
          }
        }
      })
      
    }
    .navigationTitle("Manage Cards")
    .environment(\.editMode, $editMode)
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
  @Binding var card: Card
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 5.0)
        
        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
      
      Text(card.front.text)
        .foregroundColor(.yellow)
        .bold()
        .padding(.horizontal, 5.0)
      //        .padding(.vertical, -5.0)
    }
    .aspectRatio(2/3, contentMode: .fill)
    //    .frame(width: 130, height: 150)
  }
  
  
}

extension ManageCardsView {
  class ViewModel: ObservableObject {
    
  }
}

struct ManageCardsView_Previews: PreviewProvider {
  static var previews: some View {
    //      UIElementPreview(
    
    NavigationView {
      ManageCardsView(deck: .constant(Deck(cards: [Card](repeating: Card.example, count: 300))))
        .preferredColorScheme(.dark)
    }
    .navigationViewStyle(StackNavigationViewStyle())
    //      )
  }
}
