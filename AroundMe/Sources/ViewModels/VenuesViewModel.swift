//
//  RootViewModel.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import Combine
import ForsquareAPI
import MapKit

class VenuesViewModel: ObservableObject {
    private var lastCoordinates = CLLocation(latitude: 0, longitude: 0)
    private let venueLoader: VenueLoader
    private let locationService: LocationService
    private let visibleCategories = CategorieID.allCases.map { $0.rawValue }
    private var locationSubscription: AnyCancellable?
    private var venuesSubscription: AnyCancellable?
    
    @Published var curentLocation: CLLocation
    @Published var venues: [MKAnnotation] = []
    @Published var selectedCategorie: CategoryModel {
        didSet {
            venueLoader.getVenues(around: lastCoordinates.coordinate, category: selectedCategorie, radius: 250)
        }
    }
    var categories: [CategoryModel]
    
    internal init(locationService: LocationService, venueService: VenueLoader, categories: [ForsquareAPI.Category]) {
        self.locationService = locationService
        self.venueLoader = venueService
        self.curentLocation = locationService.currentLocation
        
        let categories = categories.reduce(categories) { $0 + ( $1.categories ?? []) }.map(CategoryModel.init)
        self.categories = categories
        selectedCategorie = self.categories.first { $0.id == CategorieID.food.rawValue } ?? categories[0]
        
        locationSubscription = locationService.didChange.sink(receiveValue: locationUpdated)
        venuesSubscription = venueService.didChange
            .map({ (items: [Venue]) -> [VenueModel] in
                return items.map(VenueModel.init)
            })
            .sink(receiveCompletion: onFailure, receiveValue: onSuccess)
    }

    func locationUpdated(coordinates: CLLocation) {
        curentLocation = coordinates
        if lastCoordinates.distance(from: curentLocation) > 100 {
            lastCoordinates = curentLocation
            venueLoader.getVenues(around: coordinates.coordinate, category: selectedCategorie, radius: 250)
        }
    }
    
    func onSuccess(_ input: [VenueModel]) {
        DispatchQueue.main.async {
            self.venues = input
        }
    }
    
    func onFailure(completion: Subscribers.Completion<Error>) {
    }
}
