//
//  SettingsView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
      List {
        NavigationLink(
          destination: VoiceSettingsView()) {
            Label("Voice Settings", systemImage: "wave.3.right")
          }
      }
      .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        SettingsView()
      }
    }
}
