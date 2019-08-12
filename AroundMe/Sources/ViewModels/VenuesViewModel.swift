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
    private let venueLoader: VenueLoader
    private let locationService: LocationService
    private let visibleCategories = CategorieID.allCases.map { $0.rawValue }
    private var locationSubscription: AnyCancellable?
    
    @Published var curentLocation: CLLocation
    @Published var venuse: [VenueModel] = []
    @Published var selectedCategorie: CategoryModel
    var categories: [CategoryModel]
    
    internal init(locationService: LocationService, venueService: VenueLoader, categories: [ForsquareAPI.Category]) {
        self.locationService = locationService
        self.venueLoader = venueService
        self.curentLocation = locationService.currentLocation
        
        let categories = categories.reduce(categories) { $0 + ( $1.categories ?? []) }.map(CategoryModel.init)
        self.categories = categories
        selectedCategorie = self.categories.first { $0.id == CategorieID.food.rawValue } ?? categories[0]
        
        locationSubscription = locationService.didChange.sink(receiveValue: locationUpdated)
    }

    func locationUpdated(coordinates: CLLocation) {
        curentLocation = coordinates
        venueLoader.getVenues(around: coordinates.coordinate, category: selectedCategorie, radius: 1000)
    }
    
}
