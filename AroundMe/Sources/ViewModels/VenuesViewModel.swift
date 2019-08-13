//
//  RootViewModel.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import Combine
import FoursquareAPI
import MapKit

class VenuesViewModel: ObservableObject {
    private let maxRadius: Double
    private var lastRadius: Double = 0
    private var lastCoordinates = CLLocation(latitude: 0, longitude: 0)
    private let venueLoader: VenueLoader
    private let locationService: LocationService
    private let visibleCategories = CategorieID.allCases.map { $0.rawValue }
    private var locationSubscription: AnyCancellable?
    private var venuesSubscription: AnyCancellable?
    
    
    @Published var curentLocation: CLLocation
    @Published var venues: [VenueModel] = []
    @Published var selectedCategorie: CategoryModel {
        didSet {
            venueLoader.getVenues(around: lastCoordinates.coordinate, category: selectedCategorie, radius: Int(radius))
        }
    }
    
    @Published var radius: Double = 250.0 {
        didSet {
            guard abs(lastRadius - radius) > 25 else { return }
            lastRadius = radius
            venueLoader.getVenues(around: lastCoordinates.coordinate,
                                  category: selectedCategorie,
                                  radius: Int(radius))
        }
    }
    
    var categories: [CategoryModel]
    
    internal init(maxRadius: Double = 2000,
                  locationService: LocationService,
                  venueService: VenueLoader,
                  categories: [FoursquareAPI.Category]) {
        self.maxRadius = maxRadius
        self.locationService = locationService
        self.venueLoader = venueService
        self.curentLocation = locationService.currentLocation
        
        let filterCaregories = Set<String>(CategorieID.allCases.map { $0.rawValue })
        let categoriesModels = categories
            .reduce(categories) { $0 + ( $1.categories ?? []) }
            .filter { filterCaregories.contains($0.id) }
            .map(CategoryModel.init)
        
        self.categories = categoriesModels
        self.selectedCategorie = categoriesModels.first { $0.id == CategorieID.food.rawValue } ?? categoriesModels[0]
        locationSubscription = locationService.didChange.sink(receiveValue: locationUpdated)
        venuesSubscription = venueService.didChange
            .map { $0.map(VenueModel.init) }
            .sink(receiveCompletion: onFailure, receiveValue: onSuccess)
    }

    func locationUpdated(coordinates: CLLocation) {
        curentLocation = coordinates
        if lastCoordinates.distance(from: curentLocation) > radius / 4 {
            lastCoordinates = curentLocation
            venueLoader.getVenues(around: coordinates.coordinate, category: selectedCategorie, radius: Int(radius))
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
