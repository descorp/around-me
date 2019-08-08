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
    private let defaultIconSize = 64
    private let model: Venue
    
    var id: String {
        return model.id
    }
    
    var value: String {
        return model.name
    }
    
    var location: CLLocationCoordinate2D {
        let coordinates = model.location
        return CLLocationCoordinate2D(latitude: coordinates.lat, longitude: coordinates.lng)
    }
    
    var address: String? {
        return model.location.address
    }
    
    init(model: Venue) {
        self.model = model
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
