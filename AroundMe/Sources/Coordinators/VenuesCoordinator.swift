//
//  RootCoordinator.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import UIKit
import SwiftUI
import ForsquareAPI

class VenuesCoordinator: Coordinator {
    
    let categories: [ForsquareAPI.Category]
    let viewModel: VenuesViewModel
    
    init(categories: [ForsquareAPI.Category], parentCoordinator: Coordinator? ) {
        self.categories = categories
        self.viewModel = VenuesViewModel(venueService: Resolver.shared.get(), categories: categories)
        super.init(parentCoordinator: parentCoordinator)
    }

    override func start() {
        self.render(view: VenuesView(viewModel: viewModel))
    }
    
}
