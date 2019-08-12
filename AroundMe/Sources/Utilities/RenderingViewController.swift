//
//  RenderinfViewController.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 12/08/2019.
//

import UIKit
import SwiftUI

class UISwiftRenderingViewController: UINavigationController {
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(navigationBarClass: nil, toolbarClass: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render<S>(view: S) where S: View {
        UIView.animate(withDuration: 0.5) { self.view.alpha = 0 }
        DispatchQueue.main.async {
            self.window.rootViewController = UIHostingController(rootView: view)
        }
        UIView.animate(withDuration: 0.5) { self.view.alpha = 1 }
    }
}
