//
//  AppCoordinator.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import UIKit
import SwiftUI
import ApiProvider

class AppCoordinator: Coordinator {
    
    init(window: UIWindow) {
        super.init(rootNavigation: UISwiftRenderingViewController(window: window))
        window.rootViewController = self.rootNavigation
        window.makeKeyAndVisible()
        AppCoordinator.loadDependencies()
    }
    
    override func start() {
        let viewModel = InitViewModel(categoryLoader: Resolver.shared.get())
        let initCoordinator = InitCoordinator(viewModel: viewModel, parentCoordinator: self)
        initCoordinator.start()
    }
    
    static fileprivate func loadDependencies() {
        let apiProvider: ApiProvider = LocalApiProvider(bundle: Bundle.main, localPath: "SampleData")
        Resolver.shared.set(value: apiProvider)
        let venueLoader: VenueLoader = VenueLoaderImplementation(provider: Resolver.shared.get())
        Resolver.shared.set(value: venueLoader)
        let categoryLoader: CategoryLoader = CategoryLoaderImplementation(provider: Resolver.shared.get())
        Resolver.shared.set(value: categoryLoader)
    }
}
