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
    let bundle: Bundle
    
    public init(bundle: Bundle, localPath: String) {
        basePath = localPath
        self.bundle = bundle
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
            let resourceUrl = bundle.url(forResource: relativeString, withExtension: ".json"),
            let data = try? Data(contentsOf: resourceUrl)
        else {
            let errorMessage = "** Resource file not found: \(resourcePath.absoluteString).json"
            print(errorMessage)
            handler(.failure(ApiProviderError.invalidURL))
            return
        }
        
        do {
            let result = try endpoint.parse(data)
            handler(.success(result))
        } catch {
            handler(.failure(error))
        }
    }
}
