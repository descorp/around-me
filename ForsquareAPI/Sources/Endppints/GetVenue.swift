//
//  GetVenue.swift
//  ForsquareAPI
//
//  Created by Vladimir Abramichev on 04/08/2019.
//

import Foundation
import ApiProvider

extension Endpoint where ReturnType == FoursquareResponce<VenueResponse> {
    static func geyVenues(at location: Coordinates, radius: Int = 250, categories: Categorie...) -> Endpoint {
        return Endpoint(
            path: "/venues/search",
            body: nil,
            queryItems: [
                URLQueryItem(name: "ll", value: location.queryString),
                URLQueryItem(name: "radius", value: String(radius)),
                URLQueryItem(name: "categoryId", value: categories.queryString)
            ],
            parse: ReturnType.decode
        )
    }
}

fileprivate extension Coordinates {
    var queryString: String {
        return "\(lat),\(lng)"
    }
}

fileprivate extension Array where Element == Categorie {
    var queryString: String {
        var queryString = self.reduce("") { $0 + ",\($1.rawValue)" }
        if !queryString.isEmpty {
            queryString.removeFirst()
        }
        return queryString
    }
}
