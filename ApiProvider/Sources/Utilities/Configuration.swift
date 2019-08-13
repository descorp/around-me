//
//  EnvironmentConfiguration.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 18/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

public struct Configuration {
    public var config: [String : Any]
    
    public init(dictionary: [String : Any]) {
        config = dictionary
    }
}

public extension Configuration {

    init(bundle: Bundle, name: String = "config") {
        guard let configPath = bundle.path(forResource: name, ofType: "plist") else {
            preconditionFailure("Configuration file not found")
        }
        let config = NSDictionary(contentsOfFile: configPath)!

        var dict = [AnyHashable : Any]()
        if let commonConfig = config["Common"] as? [AnyHashable: Any] {
            dict = commonConfig
        }

        self.init(dictionary: dict as! [String : Any])
    }
}
