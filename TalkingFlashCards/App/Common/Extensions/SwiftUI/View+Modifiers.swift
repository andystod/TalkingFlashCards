//
//  View+Modifiers.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 07/03/2021.
//

import SwiftUI

extension View {
  
  typealias ContentTransform<Content: View> = (Self) -> Content
  @ViewBuilder func conditionalModifier<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        ifTrue: ContentTransform<TrueContent>,
        ifFalse: ContentTransform<FalseContent>) -> some View {
    if condition {
      ifTrue(self)
    } else {
      ifFalse(self)
    }
  }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
