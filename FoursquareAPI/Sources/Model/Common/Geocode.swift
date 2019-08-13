//
//  Geocode.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

struct Center: Codable {
    let lat, lng: Double
}

struct Geometry: Codable {
    let bounds: Bounds
}

struct Bounds: Codable {
    let ne, sw: Center
}

struct Geocode: Codable {
    let what, geocodeWhere: String
    let center: Center
    let displayString, cc: String
    let geometry: Geometry
    let slug, longID: String
    
    enum CodingKeys: String, CodingKey {
        case what
        case geocodeWhere = "where"
        case center, displayString, cc, geometry, slug
        case longID = "longId"
    }
}
