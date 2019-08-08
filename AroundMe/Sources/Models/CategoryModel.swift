//
//  CategoryModel.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import ForsquareAPI
import Combine

class CategoryModel: ListItem {
    private let defaultIconSize = 64
    private let model: ForsquareAPI.Category
    
    var id: String {
        return model.id
    }
    
    var value: String {
        return model.name
    }
    
    var iconUrl: String {
        return model.icon.prefix + "\(defaultIconSize)" + model.icon.suffix.rawValue
    }
    
    init(model: ForsquareAPI.Category) {
        self.model = model
    }
}

extension CategoryModel {
    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
