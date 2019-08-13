//
//  Response.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

struct SuggestedFilters: Codable {
    let header: String
    let filters: [Filter]
}

struct Filter: Codable {
    let name, key: String
}
