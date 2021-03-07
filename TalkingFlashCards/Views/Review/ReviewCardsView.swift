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
      HStack {
        Group {
          Image(systemName: "xmark")
            .background(Color.red)
          NavigationLink(destination: EmptyView()) {
//            Button(action: { print("Edit") }) {
              Image(systemName: "pencil")
                .background(Color.blue)
//            }
          }
          
          Image(systemName: "checkmark")
            .background(Color.green)
        }
        .font(Font.title.weight(.bold))
        .foregroundColor(.white)
      }
      .padding()
    }
    .navigationBarTitle("Review Cards", displayMode: .inline)
//    .navigationBarHidden(true)
//    .navigationTitle("")
  }
}

struct DeckView: View {
  
  @State var backViewSize: CGFloat = 80.0
  var deck: Deck
  
  
  var body: some View {
    VStack {
      ZStack {
        ForEach(Array(zip(deck.cards.indices, deck.cards)), id: \.0) { index, card in
          CardView(deck: deck, card: card)
            .offset(x: CGFloat(index * 3), y: CGFloat(index * 10))
        }
      }
    }
  }
}

struct CardView: View {
  
  @State private var offset = CGSize.zero
  //  @State var flipped = false
  
  @State private var flipped = false
  @State private var animate3d = false
  
  var deck: Deck
  var card: Card
  
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
            // remove the card
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
    
    
    
    //    .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(10), y: CGFloat(0), z: CGFloat(0)))
    //    .animation(.default)
    //    .onTapGesture {
    //      self.flipped.toggle()
    //    }
    
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
    
    let deck = Deck()
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
