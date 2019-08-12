//
//  AppDelegate.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 03/08/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import UIKit
import SwiftUI
import ApiProvider
import ForsquareAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = AppCoordinator(window: UIWindow())
        coordinator.start()
        return true
    }
}

