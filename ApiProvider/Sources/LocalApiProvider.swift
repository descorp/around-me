//
//  LocalApiProvider.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 19/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

public class LocalApiProvider: ApiProvider {
    let basePath: String
    
    init(localPath: String) {
        basePath = localPath
    }
    
    // Map the call to the folder structure (which is default behaviour)
    public func request<T>(_ endpoint: Endpoint<T>, then handler: @escaping (Result<T>) -> Void) {
        let baseUrl = URL(fileURLWithPath: basePath)
        let resourcePath = baseUrl.appendingPathComponent(endpoint.path)
        var relativeString = resourcePath.relativeString
        
        if relativeString.hasSuffix("/") {
            relativeString = String(relativeString.dropLast())
        }
        
        guard
            let resourceUrl = Bundle.main.url(forResource: relativeString, withExtension: ".json"),
            let data = try? Data(contentsOf: resourceUrl),
            let result = try? endpoint.parse(data)
        else {
            let errorMessage = "** Resource file not found for DataProvider: \(resourcePath.absoluteString).json"
            print(errorMessage)
            handler(.failure(ApiProviderError.invalidURL))
            return
        }

        handler(.success(result))
    }
}
