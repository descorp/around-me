//
//  Venue.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

struct Venue: Codable {
    let id, name: String
    let location: Location
    let categories: [Category]
    let photos: Photos?
    let venuePage: VenuePage?
    let events: Events?
}

struct VenuePage: Codable {
    let id: String
}
