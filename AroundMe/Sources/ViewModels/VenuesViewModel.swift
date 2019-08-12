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
    
    private let visibleCategories = CategorieID.allCases.map { $0.rawValue }
    
    @Published var venuse: [VenueModel] = []
    @Published var selectedCategories: CategoryModel
    var categories: [CategoryModel]
    
    private let  venueLoader: VenueLoader
    
    internal init(venueService: VenueLoader, categories: [ForsquareAPI.Category]) {
        self.venueLoader = venueService
        let flatList: [ForsquareAPI.Category] = categories.reduce(categories) { $0 + ( $1.categories ?? []) }
        let categories = flatList.map(CategoryModel.init)
        self.categories = categories
        selectedCategories = self.categories.first { $0.id == CategorieID.food.rawValue } ?? categories[0]
    }

    func locationUpdated(coordinates: CLLocationCoordinate2D) {
        venueLoader.getVenues(around: coordinates, category: selectedCategories, radius: 1000)
    }
    
}
