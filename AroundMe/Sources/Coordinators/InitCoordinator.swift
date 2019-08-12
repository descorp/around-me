//
//  LoadingCoordinator.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 10/08/2019.
//

import UIKit
import SwiftUI
import ForsquareAPI

class InitCoordinator: Coordinator {

    private var viewModel: InitViewModel
    
    override init(parentCoordinator: Coordinator? = nil) {
        viewModel = InitViewModel(categoryLoader: Resolver.shared.get())
        super.init(parentCoordinator: parentCoordinator)
         
        self.viewModel.delegate = self
    }
    
    override func start() {
        self.render(view: LoadingView(title: "Loading categories...", viewModel: viewModel))
        viewModel.loadData()
    }
}

extension InitCoordinator: InitViewModelDelegate {
    func didLoadCategories(_ categories: [ForsquareAPI.Category]) {
        let venueCoordinator = VenuesCoordinator(categories: categories, parentCoordinator: self)
        venueCoordinator.start()
    }
    
    func didFail(_ error: Error) {
        let errorCoordinate = ErrorCoordinator(error: error, parentCoordinator: self)
        errorCoordinate.start()
    }
}
