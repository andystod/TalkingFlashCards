//
//  HomeView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI

struct HomeView: View {
  
  @State var selectedTab: Int = 0
  
  var body: some View {
    TabView(selection: $selectedTab) {
      VStack {
        Text("Tab Content 0")
        Text("Hello World!")
        Text("Goodbye!")
        Text("Tab Selected: \(selectedTab)")
      }
      .tabItem {
        Label("Review", systemImage: "rectangle.stack.fill")
      }
      .tag(0)
      
      VStack {
        Text("Tab Content 1")
        Text("Tab Selected: \(selectedTab)")
      }
      .tabItem {
        Label("Add", systemImage: "plus.rectangle.fill.on.rectangle.fill")
      }
      .tag(1)
      
      VStack {
        Text("Tab Content 2")
        Text("Tab Selected: \(selectedTab)")
      }
      .tabItem {
        Label("More", systemImage: "ellipsis")
      }
      .tag(2)
      
    }
    
    
    
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .preferredColorScheme(.dark)
    HomeView()
      .preferredColorScheme(.light)
    HomeView()
      .preferredColorScheme(.none)
//      .previewedInAllColorSchemes
//      .environment(\.locale, .init(identifier: "en"))
//    HomeView()
//      .environment(\.locale, .init(identifier: "es"))
  }
}

//extension View {
//  var previewedInAllColorSchemes: some View {
//    preferredColorScheme(.dark)
//
//  }
//}
