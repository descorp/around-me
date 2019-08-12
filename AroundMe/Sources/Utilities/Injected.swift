//
//  Injected.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import Foundation

@propertyWrapper
struct Injected<T: AnyObject> {
    private var _wrappedValue: T!
    public var container: Resolver = Resolver.shared
    public var wrappedValue: T {
        mutating get {
            if _wrappedValue == nil {
                _wrappedValue = self.container.get()
            }
            return _wrappedValue
        }
        mutating set {
            _wrappedValue = newValue
        }
    }
}
