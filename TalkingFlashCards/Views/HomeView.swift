//
//  HomeView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI

struct HomeView: View {
  
  @State var selectedTab: Tabs = .review
  
  var body: some View {
    
    NavigationView {
      TabView(selection: $selectedTab) {
        VStack {
          Text("Review Content")
        }
        .tabItem {
          Label("Review", systemImage: "rectangle.stack.fill")
        }
        .tag(Tabs.review)
        
        VStack {
          AddView()
        }
        .tabItem {
          Label("Add", systemImage: "plus.rectangle.fill.on.rectangle.fill")
        }
        .tag(Tabs.add)
        
        VStack {
          MoreView()
        }
        .tabItem {
          Label("More", systemImage: "ellipsis")
        }
        .tag(Tabs.more)
        
      }
      .navigationTitle(LocalizedStringKey(getNavBarTitleForTab(selectedTab)))
    }
    .accentColor(.yellow) // TODO
    
  }
  
  enum Tabs{
    case review, add, more
  }
  
  func getNavBarTitleForTab(_ tab: Tabs) -> String {
    switch tab{
    case .review: return "Review" // test localization
    case .add: return "Add"
    case .more: return "More"
    }
  }
  
  
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .preferredColorScheme(.dark)
    //    HomeView()
    //      .preferredColorScheme(.light)
    //    HomeView()
    //      .preferredColorScheme(.none)
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
