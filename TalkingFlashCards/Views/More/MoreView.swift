//
//  MoreView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import SwiftUI

struct MoreView: View {
  var body: some View {
      List {
        NavigationLink(destination: SettingsView()){
          Label("Settings", systemImage: "gear")
          
        
//          Text("Settings")
        }
        NavigationLink(destination: ContactView()){
          Label("Contact", systemImage: "envelope.fill")
        }
      }
      .navigationTitle("More")
  }
}


struct MoreView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      MoreView()
    }
  }
}
