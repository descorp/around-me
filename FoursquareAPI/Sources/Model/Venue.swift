//
//  Venue.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

public struct Venue: Codable {
    public let id, name: String
    public let location: Location
    public let categories: [Category]
    public let photos: Photos?
    public let venuePage: VenuePage?
    public let events: Events?
}

public struct VenuePage: Codable {
    let id: String
}
