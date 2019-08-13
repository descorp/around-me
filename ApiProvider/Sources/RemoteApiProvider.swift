//
//  DataProvider.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 19/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

public protocol RequestBuilder {
    func buildRequest<T>(for endpoint: Endpoint<T>) throws -> URLRequest
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
    
    open func request<T>(_ endpoint: Endpoint<T>, then handler: @escaping (Result<T>) -> Void) {
        let request: URLRequest
        do {
            request = try builder.buildRequest(for: endpoint)
        } catch {
            return handler(.failure(ApiProviderError.invalidURL))
        }
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                return handler(.failure(ApiProviderError.network(error)))
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let error = ApiProviderError.response(code: httpResponse.statusCode,
                                                      message: String(data: data ?? Data(), encoding: .utf8))
                return handler(.failure(error))
            }
            
            guard let data = data else {
                return handler(.failure(ApiProviderError.noData))
            }
            
            do {
                let result = try endpoint.parse(data)
                handler(.success(result))
            } catch {
                handler(.failure(error))
            }
        }
        
        task.resume()
    }
}
