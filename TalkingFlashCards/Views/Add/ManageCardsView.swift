////
////  ManageCardsView.swift
////  TalkingFlashCards
////
////  Created by Andrew Stoddart on 04/03/2021.
////
//
//import SwiftUI
//
//struct ManageCardsView: View {
//  
//  @Environment(\.horizontalSizeClass) var horizontalSizeClass
//  @State var editMode: EditMode = .inactive
//  @State var showAlert = false
//  @State var TODO = false
//  @ObservedObject var cardStore: CardStore
//  
//  private var threeColumnGrid = [GridItem(.flexible(minimum: 100, maximum: 200)),
//                                 GridItem(.flexible(minimum: 100, maximum: 200)),
//                                 GridItem(.flexible(minimum: 100, maximum: 200)),
//                                 GridItem(.flexible(minimum: 100, maximum: 200)),
//                                 GridItem(.flexible(minimum: 100, maximum: 200))]
//  
//  init(cardStore: CardStore) { // TODO update constructor
//    self.cardStore = cardStore
//    UIToolbar.appearance().tintColor = UIColor(Color.red)
//  }
//  
//  var body: some View {
//    Button(action: {
//      print(cardStore.cards)
//      print(cardStore.cards.hasSelectedItems)
//      if cardStore.cards.hasSelectedItems {
//        TODO = true }
//      else {
//        TODO = false
//      }
//    }, label: {
//      Text("Button")
//    })
//    Text(String(cardStore.cards.hasSelectedItems))
//    Text(String(TODO))
//    ScrollView(.vertical) {
//      LazyVGrid(columns: getGridItems(), spacing: 10.0, content: {
//        ForEach(cardStore.cards) { card in
//          CollageCardItemView(card: $cardStore.cards[cardStore.cards.firstIndex(where: { $0.id == card.id })!],
//                              editMode: $editMode)
//        }
//      })
//      .padding()
//      .conditionalModifier(editMode == .inactive, ifTrue: {
//        $0.toolbar{
//          ToolbarItem {
//            EditButton()
//          }
//        }
//      }, ifFalse: {
//        $0.toolbar{
//          ToolbarItem {
//            EditButton()
//          }
//          ToolbarItem(placement: .bottomBar) {
//            Spacer()
//          }
//          ToolbarItem(placement: .bottomBar) {
//            Text("Select Items")
//              .bold()
//          }
//          ToolbarItem(placement: .bottomBar) {
//            Spacer()
//          }
//          ToolbarItem(placement: .bottomBar) {
//            Button(action: {
//              showAlert = true
//            }) {
//              Image(systemName: "trash")
//            }
//            .disabled(!cardStore.cards.hasSelectedItems)
////            .disabled(!TODO) // TODO change to work on selected items
//            
//          }
//        }
//      })
//      
//    }
//    .navigationTitle("Manage Cards")
//    .environment(\.editMode, $editMode)
//    .alert(isPresented: $showAlert) {
//      Alert(title: Text("Delete Cards?"), message: Text("This cannot be undone"), primaryButton: .destructive(Text("Delete"), action: {
//        print("Delete")
//        cardStore.deleteCards()
//      }), secondaryButton: .cancel())
//    }
//    //    .environmentObject(<#T##object: ObservableObject##ObservableObject#>)
//  }
//  
//  func getGridItems() -> [GridItem] {
//    if horizontalSizeClass == .compact {
//      return [GridItem(.flexible(minimum: 100, maximum: 200)),
//              GridItem(.flexible(minimum: 100, maximum: 200)),
//              GridItem(.flexible(minimum: 100, maximum: 200))]
//    } else {
//      return [GridItem(.flexible(minimum: 100, maximum: 300)),
//              GridItem(.flexible(minimum: 100, maximum: 300)),
//              GridItem(.flexible(minimum: 100, maximum: 300)),
//              GridItem(.flexible(minimum: 100, maximum: 300)),
//              GridItem(.flexible(minimum: 100, maximum: 300))]
//    }
//  }
//  
//}
//
//struct CollageCardItemView: View {
//  @Binding var card: Card // TODO
//  //  var card: Card
//  @State var selected: Bool = false
//  @Binding var editMode: EditMode
//  
//  var body: some View {
//    ZStack {
//      RoundedRectangle(cornerRadius: 5.0)
//        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
//      
//      Text(card.front.text)
//        .foregroundColor(.yellow)
//        .bold()
//        .padding(.horizontal, 5.0) // TODO test
//      if editMode.isEditing && selected {
//        VStack {
//          Spacer()
//          HStack {
//            Spacer()
//            Image(systemName: "checkmark.circle")
//              .foregroundColor(.white)
//              .background(Color.red)
//              .clipShape(Circle())
//              .font(.title3)
//              .padding(5)
//          }
//        }
//      }
//    }
//    .aspectRatio(2/3, contentMode: .fill)
//    .onTapGesture {
//      if editMode.isEditing {
//        card.selected.toggle() // TODO
//        selected = card.selected
//      }
//    }
//  }
//  
//  
//}
//
//extension ManageCardsView {
//  class ViewModel: ObservableObject {
//    @Published var deck: Deck
//    
//    init(deck: Deck) {
//      self.deck = deck
//    }
//  }
//}
//
//struct ManageCardsView_Previews: PreviewProvider {
//  static var previews: some View {
//    //      UIElementPreview(
//    
//    NavigationView {
//      ManageCardsView(cardStore: CardStore(cards: [Card](repeating: Card.example, count: 300)))
//        .preferredColorScheme(.dark)
//    }
//    .navigationViewStyle(StackNavigationViewStyle())
//    //      )
//  }
//}
