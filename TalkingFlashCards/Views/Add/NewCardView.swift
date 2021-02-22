//
//  NewCardView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI

// TODO need to make keyboard change depending on language

struct NewCardView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @State var front = ""
  @State var back = ""
  
  var body: some View {
    //    NavigationView {
    Form {
      Section(header: Text("Front")) {
        TextEditor(text: $front)
          .frame(minHeight: 70.0, maxHeight: 150.0)
        //          .foregroundColor(.secondary)
      }
      Section(header: Text("Back")) {
        TextEditor(text: $back)
          .frame(minHeight: 70.0, maxHeight: 150.0)
        //          .foregroundColor(.secondary)
      }
      Section {
        ZStack {
          
          RoundedRectangle(cornerRadius: 25.0)
            .strokeBorder(lineWidth: 3.0)
            .frame(width: 150, height: 42)
            .foregroundColor(.red)
          Text("Nope")
            .foregroundColor(.red)
            .font(.system(size:32))
            .fontWeight(.black)
        }
//        .rotationEffect(.init(degrees:45.0))
        //        Button("Save And Next") {
        //          // activate theme!
        //        }
      }
    }
    .navigationTitle("New Card")
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button("Save") {
          presentationMode.wrappedValue.dismiss()
        }
      }
      ToolbarItem(placement: .cancellationAction) {
        Button("Done") {
          presentationMode.wrappedValue.dismiss()
        }
      }
    }
    .navigationBarBackButtonHidden(true)
  }
  //  }
}

struct NewCardView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NewCardView()
    }
  }
}
