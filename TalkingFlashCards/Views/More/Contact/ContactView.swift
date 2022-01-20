//
//  ContactView.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 15/02/2021.
//

import SwiftUI

struct ContactView: View {
  
  @State var contact: Contact = Contact()
  
  let contactService = ContactService()
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 10) {
      Form {
        TextField("Name", text: $contact.name)
        TextField("Email", text: $contact.email)
        TextField("Title", text: $contact.title)
        
        ZStack {
          if contact.details.isEmpty == true {
            Text("Details")
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
              .foregroundColor(Color.gray)
          }
          TextEditor(text: $contact.details)
            .frame(maxHeight: .infinity)
            .padding(.horizontal, -5)
        }
        .toolbar {
          ToolbarItem(placement: ToolbarItemPlacement.confirmationAction) {
            Button("Send") {
              print("Send")
              
              Task {
                do {
                  try await contactService.addContact(contact: contact)
                } catch {
                  print(error)
                }
              
              }
              
              
            }
          }
        }
        
        
        //        VStack {
        //          Text("Details")
        //          TextEditor(text: $contact.details)
        //        }
        //        Section(header: Text("Details")) {
        //          TextEditor(text: $contact.details)
        //        }
      }
    }
    .navigationTitle("Contact")
  }
}

struct ContactView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ContactView()
        .preferredColorScheme(.dark)
      //      ContactView()
    }
  }
  
}
