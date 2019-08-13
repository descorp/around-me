//
//  Resolver.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import Foundation

class Resolver {
    
    private var container: [String: Any] = [:]
    static var shared = Resolver()
    
    func get<T: Any>() -> T {
        let name: String = String(describing: T.self)
        return container[name] as! T
    }
    
    func set<T: Any>(value: T) {
        let name: String = String(describing: T.self)
        container[name] = value
    }
}
