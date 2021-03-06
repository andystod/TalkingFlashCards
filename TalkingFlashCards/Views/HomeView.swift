//
//  HomeView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI

struct HomeView: View {
  
  @State var selectedTab: Tabs = .review
  @EnvironmentObject var deckStore: DeckStore
  
  init() {
    print("init")
  }
  
  var body: some View {
    
    NavigationView {
      TabView(selection: $selectedTab) {
        ReviewView()
        .tabItem {
          Label("Review", systemImage: "rectangle.stack.fill")
        }
        .tag(Tabs.review)
        
        VStack {
          AddView()
        }
        .tabItem {
          Label("Edit", systemImage: "square.and.pencil")
        }
        .tag(Tabs.edit)
        
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
    .navigationViewStyle(StackNavigationViewStyle())
    .accentColor(.yellow) // TODO
    
  }
  
  enum Tabs{
    case review, edit, more
  }
  
  func getNavBarTitleForTab(_ tab: Tabs) -> String {
    switch tab{
    case .review: return "Review" // test localization
    case .edit: return "Edit"
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
