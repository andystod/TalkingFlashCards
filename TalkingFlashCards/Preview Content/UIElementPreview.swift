//
//  UIElementPreview.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 05/03/2021.
//

#if DEBUG

import SwiftUI

struct UIElementPreview<Value: View>: View {
  
  private let dynamicTypeSizes: [ContentSizeCategory] = [.extraSmall, .large, .extraExtraExtraLarge]
  
  /// Filter out "base" to prevent a duplicate preview.
  private let localizations = Bundle.main.localizations.map(Locale.init).filter { $0.identifier != "base" }
  
  private let viewToPreview: Value
  
  init(_ viewToPreview: Value) {
    self.viewToPreview = viewToPreview
  }
  
  var body: some View {
    Group {
      
     
      
      self.viewToPreview
        .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        .previewDisplayName("iPhone 12 Pro Max")
        .preferredColorScheme(.dark)
       
      self.viewToPreview
        .previewLayout(.fixed(width: 2532 / 3.0, height: 1170 / 3.0))
        .environment(\.horizontalSizeClass, .regular)
        .environment(\.verticalSizeClass, .compact)
      
      
      self.viewToPreview
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        .previewDisplayName("iPhone SE (2nd generation)")
      
      self.viewToPreview
        .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (4th generation)"))
        .previewDisplayName("iPad Pro (12.9-inch) (4th generation)")
      
      
      //            self.viewToPreview
      //                .previewLayout(PreviewLayout.sizeThatFits)
      //                .padding()
      //                .previewDisplayName("Default preview 1")
      //
      //            self.viewToPreview
      //                .previewLayout(PreviewLayout.sizeThatFits)
      //                .padding()
      //                .background(Color(.systemBackground))
      //                .environment(\.colorScheme, .dark)
      //                .previewDisplayName("Dark Mode")
      
      //            ForEach(localizations, id: \.identifier) { locale in
      //                self.viewToPreview
      //                    .previewLayout(PreviewLayout.sizeThatFits)
      //                    .padding()
      //                    .environment(\.locale, locale)
      //                    .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier))
      //            }
      
      ForEach(dynamicTypeSizes, id: \.self) { sizeCategory in
        self.viewToPreview
          .previewLayout(PreviewLayout.sizeThatFits)
          .padding()
          .environment(\.sizeCategory, sizeCategory)
          .previewDisplayName("\(sizeCategory)")
      }
      
    }
  }
}

#endif
