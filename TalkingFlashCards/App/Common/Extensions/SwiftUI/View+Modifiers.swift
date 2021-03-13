//
//  View+Modifiers.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 07/03/2021.
//

import SwiftUI
import Introspect

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

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

extension View {
    public func introspectTextView(customize: @escaping (UITextView) -> ()) -> some View {
        return inject(UIKitIntrospectionView(
            selector: { introspectionView in
                guard let viewHost = Introspect.findViewHost(from: introspectionView) else {
                    return nil
                }
                return Introspect.previousSibling(containing: UITextView.self, from: viewHost)
            },
            customize: customize
        ))
    }
}
