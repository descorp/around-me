//
//  VenueModel.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import ForsquareAPI
import Combine
import MapKit

class VenueModel: Identifiable {    
    let id: String
    let name: String
    let location: CLLocationCoordinate2D
    let address: String?
    
    init(model: Venue) {
        let coordinates = model.location
        self.location = CLLocationCoordinate2D(latitude: coordinates.lat, longitude: coordinates.lng)
        self.address = model.location.address
        self.id = model.id
        self.name = model.name
    }
}

extension VenueModel {
    static func == (lhs: VenueModel, rhs: VenueModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
