//
//  ReviewCardsView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 19/02/2021.
//

import SwiftUI

struct ReviewCardsView: View {
  
  var deck: Deck
  
  var body: some View {
    VStack {
      DeckView(deck: deck)
        .padding()
    }
    .navigationBarTitle("Review Cards", displayMode: .inline)
  }
}

struct DeckView: View {
  
  @State var backViewSize: CGFloat = 80.0
  var deck: Deck
  @State var cards: [Card]
  
  init(deck: Deck) {
    self.deck = deck
    self._cards = State(wrappedValue: deck.cardStore.cards)
  }
  
  var body: some View {
    ZStack {
      ForEach(cards.indices) { index in
        CardView(deck: deck, card: $cards[index])
          .offset(offsetForCardNumber(index))
          .rotationEffect(Angle(degrees: Double.random(in: -2.0...2.0)))
          .zIndex(Double(deck.cardStore.cards.count - index - 1))
      }
    }
  }
  
  func offsetForCardNumber(_ cardNumber: Int) -> CGSize {
    return CGSize(width: CGFloat.random(in: -2.0...2.0), height: CGFloat.random(in: -2.0...2.0))
  }
}

struct CardView: View {
  
  @State private var offset = CGSize.zero
  @State private var flipped = false
  @State private var animate3d = false
  
  var deck: Deck
  @Binding var card: Card
  
  var body: some View {
    ZStack {
      CardSideView(text: card.front.text, sideSettings: deck.frontSideSettings, offset: $offset).opacity(flipped ? 0.0 : 1.0)
      CardSideView(text: card.back.text, sideSettings: deck.backSideSettings, offset: $offset).opacity(flipped ? 1.0 : 0.0)
    }
    .rotationEffect(.degrees(Double(offset.width / 5)))
    .offset(x: offset.width * 5, y: 0)
    .opacity(2 - Double(abs(offset.width / 50)))
    .gesture(
      DragGesture()
        .onChanged { gesture in
          self.offset = gesture.translation
        }
        .onEnded { _ in
          if abs(self.offset.width) > 100 {
            if self.offset.width > 0 {
              deck.cardStore.promoteCard(&card)
            } else {
              deck.cardStore.demoteCard(&card)
            }
          } else {
            self.offset = .zero
          }
        }
    )
    .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 180 : 0, axis: (x: 1, y: 0)))
    .onTapGesture {
      withAnimation(Animation.linear(duration: 0.8)) {
        self.animate3d.toggle()
      }
    }
  }
}




struct FlipEffect: GeometryEffect {
  
  var animatableData: Double {
    get { angle }
    set { angle = newValue }
  }
  
  @Binding var flipped: Bool
  var angle: Double
  let axis: (x: CGFloat, y: CGFloat)
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    
    DispatchQueue.main.async {
      self.flipped = self.angle >= 90 && self.angle < 270
    }
    
    let tweakedAngle = flipped ? -180 + angle : angle
    let a = CGFloat(Angle(degrees: tweakedAngle).radians)
    
    var transform3d = CATransform3DIdentity;
    transform3d.m34 = -1/max(size.width, size.height)
    
    transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
    transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
    
    let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
    
    return ProjectionTransform(transform3d).concatenating(affineTransform)
  }
}

struct ReviewCardsView_Previews: PreviewProvider {
  static var previews: some View {
    
    let deck = Deck(cardStore: CardStore(cards: [Card](repeating: Card(), count: 20)))
    NavigationView {
      ReviewCardsView(deck: deck)
        .preferredColorScheme(.dark)
    }
    NavigationView {
      ReviewCardsView(deck: deck)
        .preferredColorScheme(.light)
    }
  }
}
