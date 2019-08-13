//
//  Injected.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    private var _wrappedValue: T!
    
    public var wrappedValue: T {
        mutating get {
            if _wrappedValue == nil {
                _wrappedValue = Resolver.shared.get()
            }
            return _wrappedValue
        }
        
        mutating set {
            _wrappedValue = newValue
        }
    }
}
