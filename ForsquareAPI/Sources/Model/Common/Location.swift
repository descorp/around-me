//
//  Location.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

struct Coordinates: Codable {
    let lat, lng: Double
}

struct Location: Codable {
    let lat, lng: Double
    let labeledLatLngs: [Coordinates]
    let formattedAddress: [String]
    let address, cc, city, state, country, crossStreet, postalCode, neighborhood: String?
}