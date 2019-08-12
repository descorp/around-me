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
    //private var viewController: UIViewController!
    private var viewModel: InitViewModel
    
    init(viewModel: InitViewModel, parentCoordinator: Coordinator? = nil) {
        self.viewModel = viewModel
        super.init(parentCoordinator: parentCoordinator)
        
        self.viewModel.delegate = self
    }
    
    override func start() {
        let view = LoadingView(title: "Loading categories...", viewModel: viewModel)
        (rootNavigation as? UISwiftRenderingViewController)?.render(view: view)
        viewModel.loadData()
    }
}

extension InitCoordinator: InitViewModelDelegate {
    func didLoadCategories(_ categories: [ForsquareAPI.Category]) {
        let viewModel = VenuesViewModel(venueService: Resolver.shared.get(), categories: categories)
        self.render(view: VenuesView(viewModel: viewModel))
    }
    
    func didFail(_ error: Error) {
        let errorCoordinate = ErrorCoordinator(error: error, parentCoordinator: self)
        errorCoordinate.start()
    }
}
