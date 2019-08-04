//
//  Configuration.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 04/08/2019.
//

import Foundation

enum ConfigParameter: String {
    case client_id
    case client_secret
    case url
    case version
    case version_date
}

extension Configuration {
    subscript(property: ConfigParameter) -> String {
        get {
            guard let propertyValue = config[property.rawValue] as? String else {
                preconditionFailure("\(property.rawValue) is not configured correctly")
            }
            return propertyValue
        }
    }
}
