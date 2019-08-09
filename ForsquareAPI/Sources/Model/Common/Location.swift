//
//  Location.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

public struct Coordinates: Codable {
    public let lat, lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lng = lng
        self.lat = lat
    }
}

public struct Location: Codable {
    public let lat, lng: Double
    public let labeledLatLngs: [Coordinates]
    public let formattedAddress: [String]
    public let address, cc, city, state, country, crossStreet, postalCode, neighborhood: String?
}
