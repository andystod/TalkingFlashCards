//
//  Array+RemoveDuplicates.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 25/02/2021.
//

extension Array {
  func removingDuplicates<T: Hashable>(byKey key: KeyPath<Element, T>)  -> [Element] {
    var seenKeys = Set<T>()
    return self.filter { candidate in seenKeys.insert(candidate[keyPath: key]).inserted }
  }
  
  func removingDuplicates<T: Hashable>(byKey deriveKey: (Element) -> T)  -> [Element] {
    var seenKeys = Set<T>()
    return self.filter { candidate in seenKeys.insert(deriveKey(candidate)).inserted }
  }
}
