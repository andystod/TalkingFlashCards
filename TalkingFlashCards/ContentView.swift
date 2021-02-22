//import SwiftUI
//
//struct ContentView: View {
//
//      @State private var flipped = false
//      @State private var animate3d = false
//
//      var body: some View {
//
//            return VStack {
//                  Spacer()
//
//                  ZStack() {
//                        FrontCard().opacity(flipped ? 0.0 : 1.0)
//                        BackCard().opacity(flipped ? 1.0 : 0.0)
//                  }
//                  .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 180 : 0, axis: (x: 1, y: 0)))
//                  .onTapGesture {
//                        withAnimation(Animation.linear(duration: 0.8)) {
//                              self.animate3d.toggle()
//                        }
//                  }
//                  Spacer()
//            }
//      }
//}
//
//struct FlipEffect: GeometryEffect {
//
//      var animatableData: Double {
//            get { angle }
//            set { angle = newValue }
//      }
//
//      @Binding var flipped: Bool
//      var angle: Double
//      let axis: (x: CGFloat, y: CGFloat)
//
//      func effectValue(size: CGSize) -> ProjectionTransform {
//
//            DispatchQueue.main.async {
//                  self.flipped = self.angle >= 90 && self.angle < 270
//            }
//
//            let tweakedAngle = flipped ? -180 + angle : angle
//            let a = CGFloat(Angle(degrees: tweakedAngle).radians)
//
//            var transform3d = CATransform3DIdentity;
//            transform3d.m34 = -1/max(size.width, size.height)
//
//            transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
//            transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
//
//            let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
//
//            return ProjectionTransform(transform3d).concatenating(affineTransform)
//      }
//}
//
//struct FrontCard : View {
//      var body: some View {
//            Text("One thing is for sure – a sheep is not a creature of the air.").padding(5).frame(width: 250, height: 150, alignment: .center).background(Color.yellow)
//      }
//}
//
//struct BackCard : View {
//      var body: some View {
//            Text("If you know you have an unpleasant nature and dislike people, this is no obstacle to work.").padding(5).frame(width: 250, height: 150).background(Color.green)
//      }
//}
//
//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView()
//  }
//}
//
//
//////
//////  ContentView.swift
//////  TalkingFlashCards
//////
//////  Created by Andrew Stoddart on 13/02/2021.
//////
////
////import SwiftUI
////import AVFoundation
////
////struct ContentView: View {
////
////  @State var pickerSelection: String = ""
////
////  var body: some View {
////    VStack {
////
////      Picker("Select Language", selection: $pickerSelection)
////      {
////
////        ForEach(LocalLanguageService().getUniqueLanguages(), id: \.self) { language in
////          Text(language)
////        }
////
////
////      }.id(UUID())
////
////      Text("You selected: \(pickerSelection)")
////
////
////      Text("Hello, world!")
////        .padding()
////        .onAppear(perform: {
////          //          printLanguages()
////        } )
////      Button(action: {
////              speak(pickerSelection) }, label: {
////                Text("Speak")
////              }
////      )
////
////      Button(action: {
////              getLanguages() }, label: {
////                Text("Languages")
////              }
////      )
////
////      Button(action: {
////              printEnglishLanguages() }, label: {
////                Text("English Languages")
////              }
////      )
////
////    }
////  }
////}
////
////func printEnglishLanguages() {
////  let locale = NSLocale.autoupdatingCurrent
////  print(locale.localizedString(forLanguageCode: "en-US")!)
////  print(locale.localizedString(forLanguageCode: "en-UK")!)
////
////
////  print(locale.localizedString(forIdentifier: "en-UK"))
////  print(locale.localizedString(forRegionCode: "en-UK"))
////
////}
////
////
////func getLanguages() -> [String] {
////  let voices = AVSpeechSynthesisVoice.speechVoices()
////
////
////  let locale = NSLocale.autoupdatingCurrent
////
////  //  locale.localizedString(forLanguageCode: <#T##String#>)
////
////
////
////  var languages = voices.map { locale.localizedString(forLanguageCode: $0.language) ?? "" }
////
////  print(languages)
////
////  print(Set(languages))
////
//////  for voice in voices {
//////    print(locale.localizedString(forIdentifier: voice.language)!)
//////  }
////
////
////  return languages
////
////  //  for (NSString *code in languages) {
////  //        dictionary[code] = [currentLocale displayNameForKey:NSLocaleIdentifier value:code];
////  //      }
////  //      _languageDictionary = dictionary;
////  //
////  //
////  //  return voices.map { "\($0.language) - \($0.name) - \($0.quality)" }
////}
////
////struct ContentView_Previews: PreviewProvider {
////  static var previews: some View {
////    ContentView()
////  }
////}
////
////func printLanguages() {
////
////  let voices = AVSpeechSynthesisVoice.speechVoices()
////  print(voices)
////
////  //  for voice in (AVSpeechSynthesisVoice.speechVoices()){
////  //    print(voice.language)
////  //  }
////
////  //  speak()
////
////}
////
////func speak(_ language: String) {
////
////  //  let langCode = Locale.current.languageCode ?? ""
////  //  let regionCode = Locale.current.regionCode ?? ""
////  //  let language = "\(langCode)-\(regionCode)"
////  //  print(language)
////  //  print(NSLocale.current.identifier)
////
////
////
////  let speakTalk   = AVSpeechSynthesizer()
////  //  let speakMsg    = AVSpeechUtterance(string: "Hola el mundo, puedo hablar")
////
////  let speakMsg    = AVSpeechUtterance(string: "Hello I am Andrew")
////
////  //  speakMsg.voice  = AVSpeechSynthesisVoice(language: "es-MX")
////
////  speakMsg.voice  = AVSpeechSynthesisVoice(language: language)
////
////  speakMsg.pitchMultiplier = 1.2
////  speakMsg.rate   = 0.5
////
////  speakTalk.speak(speakMsg)
////
////}
