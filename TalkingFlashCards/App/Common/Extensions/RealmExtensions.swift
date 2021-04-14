//
//  RealmExtensions.swift
//  TalkingFlashCards
//
//  Created by Andrew Stoddart on 12/04/2021.
//

import Foundation
import Combine
import RealmSwift

extension Publisher {
    func writeObject<T: Object>(type: T.Type, receiveOn callbackQueue: DispatchQueue)
        -> AnyPublisher<T, Error> where Output == Any, Failure == Error { // 1
            let publisher = self
                .flatMap { value in
                    RealmSwift.RealmPublishers.AddObject(type: type, value: value) // 2
                }
//                .subscribe(on: realmQueue) // 3
                .threadSafeReference() // 4
                .receive(on: callbackQueue) // 5
            return publisher.eraseToAnyPublisher() // 6
    }
}

extension RealmSwift.RealmPublishers {
    struct AddObject<T: Object>: Publisher {
        public typealias Output = T // 1
        public typealias Failure = Error // 2
        
        private let type: T.Type
        private let value: Any

        init(type: T.Type, value: Any) {
            self.type = type
            self.value = value
        }

        public func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Error, S.Input == T { // 3
            let subscription = RealmWriteSubscription(subscriber: subscriber, type: type, value: value) // 4
            subscriber.receive(subscription: subscription) // 5
        }
    }
}


extension RealmSwift.RealmPublishers {
    class RealmWriteSubscription<S: Subscriber, T: Object>: Subscription where S.Input == T, S.Failure == Error { // 1
        private var subscriber: S?
        private let type: T.Type
        private let value: Any
        private var result: Result<T, Error>?
        
        init(subscriber: S, type: T.Type, value: Any) {
            self.subscriber = subscriber
            self.type = type
            self.value = value
        }

        func request(_ demand: Subscribers.Demand) { // 2
            switch result {
            case .success(let object): _ = subscriber?.receive(object)
            case .failure(let error): subscriber?.receive(completion: .failure(error))
            case nil: addToRealm()
            }
        }
        
        func cancel() { // 3
            subscriber = nil
        }
        
        private func addToRealm() {
            do {
                let realm = try Realm()
                let object: T
                if realm.isInWriteTransaction {
                    object = realm.create(type, value: value)
                } else {
                    realm.beginWrite()
                    object = realm.create(type, value: value)
                    try realm.commitWrite()
                }
                result = .success(object)
                _ = subscriber?.receive(object) // 4
                subscriber?.receive(completion: .finished) // 5
            } catch {
                result = .failure(error)
                subscriber?.receive(completion: .failure(error)) // 6
            }
        }
    }
}
