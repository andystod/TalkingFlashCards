//
//  ContactService.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 20/01/2022.
//

import Foundation
import RealmSwift

protocol ContactServiceProtocol {
  func addContact(contact: Contact) async throws
}

class ContactService {
  
  func addContact(contact: Contact) async throws {
    try await withCheckedThrowingContinuation { (continuation: _Concurrency.CheckedContinuation<Void, Error>) in
      do {
        let realm = try Realm()
        let contactDB = ContactDB(contact)
        try realm.write {
          realm.add(contactDB)
          continuation.resume()
        }
      } catch {
        continuation.resume(throwing: error)
      }
    }
  }
}
