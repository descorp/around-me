//
//  CoordinatorExtensions.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 12/08/2019.
//

import SwiftUI

extension Coordinator {
    func render<T: View>(view: T) {
        (self.rootNavigation as? UISwiftRenderingViewController)?.render(view: view)
    }
}
