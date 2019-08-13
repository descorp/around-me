//
//  CategoryModel.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import FoursquareAPI
import Combine
import UIKit

class CategoryModel: ListItem {
    private let defaultIconSize = 64
    
    let id: String
    let name: String
    let iconUrl: String?
    
    init(model: FoursquareAPI.Category) {
        id = model.id
        name = model.name
        iconUrl = model.icon.prefix + "\(defaultIconSize)" + model.icon.suffix.rawValue
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
