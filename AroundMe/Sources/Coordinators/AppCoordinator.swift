//
//  AppCoordinator.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import UIKit
import SwiftUI
import ApiProvider
import FoursquareAPI

class AppCoordinator: Coordinator {
    
    init(window: UIWindow) {
        super.init(rootNavigation: UISwiftRenderingViewController(window: window))
        window.rootViewController = self.rootNavigation
        window.makeKeyAndVisible()
        AppCoordinator.loadDependencies()
    }
    
    override func start() {
        let initCoordinator = InitCoordinator(parentCoordinator: self)
        initCoordinator.start()
    }
    
    static fileprivate func loadDependencies() {
        let apiProvider: ApiProvider = RemoteApiProvider(with: ForsquareUrlRequestBuilder(with: Configuration(bundle: Bundle.main)))
        Resolver.shared.set(value: apiProvider)
        Resolver.shared.set(value: VenueLoaderImplementation(provider: Resolver.shared.get()) as VenueLoader)
        Resolver.shared.set(value: CategoryLoaderImplementation(provider: Resolver.shared.get()) as CategoryLoader)
        Resolver.shared.set(value: LocationServiceImplementation() as LocationService)
    }
}
