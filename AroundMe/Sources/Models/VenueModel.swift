//
//  VenueModel.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import ForsquareAPI
import Combine
import MapKit

class VenueModel: NSObject, Identifiable {
    let id: String
    let name: String
    let location: CLLocation
    let address: String?
    
    init(model: Venue) {
        let coordinates = model.location
        self.location = CLLocation(latitude: coordinates.lat, longitude: coordinates.lng)
        self.address = model.location.address
        self.id = model.id
        self.name = model.name
    }
    
    override var hash: Int {
        return id.hashValue
    }
}

extension VenueModel: MapPin {
    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
    
    var title: String? {
        return name
    }
}

extension VenueModel {
    static func == (lhs: VenueModel, rhs: VenueModel) -> Bool {
        return lhs.id == rhs.id
    }
}
