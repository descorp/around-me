//
//  ErrorCoordinator.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 12/08/2019.
//

import Foundation

class ErrorCoordinator: Coordinator {
    private let error: Error
    
    init(error: Error, parentCoordinator: Coordinator? = nil) {
        self.error = error
        super.init(parentCoordinator: parentCoordinator)
    }
    
    override func start() {
        var title = error.localizedDescription
        if error.isNoInternet {
            title = "No Internet"
        }
        
        if error.serverError {
            title = "Server Error"
        }
        
        
        self.render(view: ErrorView(title: title))
    }
    
}


extension Error {
    var isNoInternet: Bool {
        return (self as? URLError)?.code == .notConnectedToInternet
    }
    
    var serverError: Bool {
        return (self as? URLError)?.code == .badServerResponse
    }
}
