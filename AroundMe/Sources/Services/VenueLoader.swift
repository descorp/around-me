//
//  VenueLoader.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 08/08/2019.
//

import Foundation
import ForsquareAPI
import ApiProvider
import MapKit

protocol VenueLoader: ObservableObject {
    func getVenues(around coordinate:CLLocationCoordinate2D, category: CategoryModel, radius: Int)
    var venues: [VenueModel] { get }
}

class VenueLoaderImplementation: ObservableObject, VenueLoader {
    @Published var venues: [VenueModel] = []
    
    init(provider: ApiProvider) {
        self.apiProvider = provider
    }
    
    let apiProvider: ApiProvider  //RemoteApiProvider(with: ForsquareUrlRequestBuilder(with: Configuration(bundle: Bundle.main)))
    
    func getVenues(around coordinate: CLLocationCoordinate2D, category: CategoryModel, radius: Int = 250) {
        let forsquareCoordinate = Coordinates(lat: coordinate.latitude, lng: coordinate.longitude)
        apiProvider.request(Endpoint.getVenues(at: forsquareCoordinate, radius: radius, categories: category.id)) { response in
            
        }
    }
}
