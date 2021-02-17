//
//  NewCardView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 14/02/2021.
//

import SwiftUI

struct NewCardView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @State var front = ""
  @State var back = ""
  
  var body: some View {
    //    NavigationView {
    Form {
      Section(header: Text("Front")) {
        TextEditor(text: $front)
        //          .foregroundColor(.secondary)
      }
      Section(header: Text("Back")) {
        TextEditor(text: $back)
        //          .foregroundColor(.secondary)
      }
      Section {
        Button("Save And Next") {
          // activate theme!
        }
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
        Button("Cancel") {
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
