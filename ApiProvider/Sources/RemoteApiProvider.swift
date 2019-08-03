//
//  DataProvider.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 19/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

public protocol RequestBuilder {
    func buildRequest<T>(for endpoint: Endpoint<T>) -> URLRequest?
}

public class RemoteApiProvider: ApiProvider {
    private let builder: RequestBuilder
    private static let sessionSecurity = SecureURLSession()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default,
                                        delegate: sessionSecurity,
                                        delegateQueue: nil)
    
    public init(with builder: RequestBuilder) {
        self.builder = builder
    }
    
    public func request<T>(_ endpoint: Endpoint<T>, then handler: @escaping (Result<T>) -> Void) {
        guard let request = builder.buildRequest(for: endpoint) else {
            return handler(.failure(ApiProviderError.invalidURL))
        }
        
        let task = urlSession.dataTask(with: request) { data, _, error in
            if let error = error {
                handler(.failure(ApiProviderError.network(error)))
                return
            }
            
            guard let data = data else {
                handler(.failure(ApiProviderError.noData))
                return
            }
            
            do {
                let result = try endpoint.parse(data)
                handler(.success(result))
            }
            catch let error {
                handler(.failure(error))
            }
            
        }
        
        task.resume()
    }
}
