//
//  CardSideView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 21/02/2021.
//

import SwiftUI
import AVFoundation

struct CardSideView: View {
  
  var text: String
  var sideSettings: SideSettings
  @Binding var offset: CGSize
//  @State var speaking = false
  @StateObject var speaker = Speaker()
  
  
  
  func gradientColors() -> [Color] {
    var colors = [Color.blue.opacity(1 - Double(abs(offset.width / 50))), Color.purple.opacity(1 - Double(abs(offset.width / 50)))]
    if sideSettings.side == .back {
      colors.reverse()
    }
    return colors
  }
  
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25, style: .continuous)
        .fill(
          
          //          RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
          
          LinearGradient(gradient: Gradient(colors: gradientColors()), startPoint: .topLeading, endPoint: .bottomTrailing)
          
          //          Color.white
          
          
          
        )
        .background(
          RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(offset.width > 0 ? Color.green : Color.red)
        )
        .shadow(radius: 1)
        .padding()
      VStack {
        Spacer()
        Text(text)
          .foregroundColor(.yellow)
          .font(.title)
          .bold()
        Spacer()
        Button(action: {
          speaker.speak(text, languageCode: sideSettings.languageCode) // TODO
        }, label: {
          Image(systemName: speaker.isSpeaking ? "speaker.wave.3.fill" : "speaker.fill")
        })
        
        .padding(.leading, speaker.isSpeaking ? 17.5 : 0)
        .padding(.bottom, speaker.isSpeaking ? 29 : 30)
        .foregroundColor(.yellow)
        .font(.title)
      }
    }
  }
}


