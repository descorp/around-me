//
//  GetVenue.swift
//  FoursquareAPI
//
//  Created by Vladimir Abramichev on 04/08/2019.
//

import Foundation
import ApiProvider

public struct VenueResponse: Codable {
    public let venues: [Venue]
}

public extension Endpoint where ReturnType == FoursquareResponce<VenueResponse> {
    static func getVenues(at location: Coordinates, radius: Int = 250, categories: [String]? = nil) -> Endpoint {
        var queryItems = [
            URLQueryItem(name: "ll", value: location.queryString),
            URLQueryItem(name: "radius", value: String(radius)) ]
        
        if let categories = categories {
            queryItems.append(URLQueryItem(name: "categoryId", value: categories.joined(separator: ",")))
        }
        
        return Endpoint(
            path: "/venues/search",
            body: nil,
            queryItems: queryItems,
            parse: ReturnType.decode
        )
    }
    
    static func getVenues(at location: Coordinates, radius: Int = 250, categories: String...) -> Endpoint {
        return Endpoint.getVenues(at: location, radius: radius, categories: categories)
    }
    
    static func getVenues(at location: Coordinates, radius: Int = 250, categories: CategorieID...) -> Endpoint {
        return Endpoint.getVenues(at: location, radius: radius, categories: categories.map { $0.rawValue } )
    }
}

fileprivate extension Coordinates {
    var queryString: String {
        return "\(lat),\(lng)"
    }
}
