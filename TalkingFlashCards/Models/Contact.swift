//
//  Contact.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 20/01/2022.
//

import Foundation
import RealmSwift

struct Contact {
  var name = ""
  var email = ""
  var title = ""
  var details = ""
}

class ContactDB: Object {
  @objc dynamic var id: String = UUID().uuidString
  @objc dynamic var name: String = ""
  @objc dynamic var email: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var details: String = ""
 
  
  convenience init(_ contact: Contact) {
    self.init()
    name = contact.name
    email = contact.email
    title = contact.title
    details = contact.details
  }
  
}
