//
//  RootCoordinator.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import UIKit
import SwiftUI
import FoursquareAPI

class VenuesCoordinator: Coordinator {
    
    let categories: [FoursquareAPI.Category]
    let viewModel: VenuesViewModel
    
    init(categories: [FoursquareAPI.Category], parentCoordinator: Coordinator? ) {
        self.categories = categories
        self.viewModel = VenuesViewModel(locationService: Resolver.shared.get(),
                                         venueService: Resolver.shared.get(),
                                         categories: categories)
        super.init(parentCoordinator: parentCoordinator)
    }

    override func start() {
        self.render(view: VenuesView(viewModel: viewModel))
    }
    
}
