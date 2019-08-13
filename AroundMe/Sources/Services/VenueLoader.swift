//
//  VenueLoader.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 08/08/2019.
//

import Combine
import FoursquareAPI
import ApiProvider
import MapKit

protocol VenueLoader {
    func getVenues(around coordinate:CLLocationCoordinate2D, category: CategoryModel, radius: Int)
    var didChange: PassthroughSubject<[Venue], Error> { get }
}

class VenueLoaderImplementation: VenueLoader {
    private let apiProvider: ApiProvider
    var didChange = PassthroughSubject<[Venue], Error>()
    
    init(provider: ApiProvider) {
        self.apiProvider = provider
    }
    
    func getVenues(around coordinate: CLLocationCoordinate2D, category: CategoryModel, radius: Int = 250) {
        #if DEBUG
        print("\n- - - - - - - - - requested \(category.name) \(radius)m around - - - - - - \n")
        #endif
        let forsquareCoordinate = Coordinates(lat: coordinate.latitude, lng: coordinate.longitude)
        apiProvider.request(Endpoint.getVenues(at: forsquareCoordinate, radius: radius, categories: category.id)) { response in
            switch response {
            case .success(let result):
                self.didChange.send(result.response.venues)
            case .failure(let error):
                self.didChange.send(completion: Subscribers.Completion<Error>.failure(error))
            }
        }
    }
}
