//
//  Category.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import Foundation

class Category: ListItem, ObservableObject {
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID()
    let value: String
    
    init(name: String) {
        value = name
    }
}
