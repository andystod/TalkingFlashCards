//
//  MoreView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import SwiftUI

struct MoreView: View {
  var body: some View {
//    NavigationView {
      VStack {
        Text("More View")
        NavigationLink(destination: SettingsView()){
          Text("Settings")
        }
        NavigationLink(destination: ContactView()){
          Text("Contact")
        }
      }
      .navigationTitle("More")
//    }
  }
}


struct MoreView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      MoreView()
    }
  }
}
