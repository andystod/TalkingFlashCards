//
//  ContentView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 13/02/2021.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
  
  @State var pickerSelection: String = ""
  
  var body: some View {
    VStack {
      
      Picker("Select Language", selection: $pickerSelection)
      {
        
        ForEach(getLanguages(), id: \.self) { language in
          Text(language)
        }
        
        
      }.id(UUID())
      
      Text("You selected: \(pickerSelection)")
      
      
      Text("Hello, world!")
        .padding()
        .onAppear(perform: {
          //          printLanguages()
        } )
      Button(action: {
              speak(pickerSelection) }, label: {
                Text("Speak")
              }
      )
      
      Button(action: {
              printLanguages() }, label: {
                Text("Languages")
              }
      )
      
    }
  }
}

func getLanguages() -> [String] {
  let voices = AVSpeechSynthesisVoice.speechVoices()
  return voices.map { $0.language }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

func printLanguages() {
  
  
  print(AVSpeechSynthesisVoice.speechVoices())
  
//  for voice in (AVSpeechSynthesisVoice.speechVoices()){
//    print(voice.language)
//  }
  
  //  speak()
  
}

func speak(_ language: String) {
  
//  let langCode = Locale.current.languageCode ?? ""
//  let regionCode = Locale.current.regionCode ?? ""
//  let language = "\(langCode)-\(regionCode)"
//  print(language)
//  print(NSLocale.current.identifier)
  
  
  
    let speakTalk   = AVSpeechSynthesizer()
    //  let speakMsg    = AVSpeechUtterance(string: "Hola el mundo, puedo hablar")
  
    let speakMsg    = AVSpeechUtterance(string: "Hello I am Andrew")
  
    //  speakMsg.voice  = AVSpeechSynthesisVoice(language: "es-MX")
  
    speakMsg.voice  = AVSpeechSynthesisVoice(language: language)
  
    speakMsg.pitchMultiplier = 1.2
    speakMsg.rate   = 0.5
  
    speakTalk.speak(speakMsg)
  
}
