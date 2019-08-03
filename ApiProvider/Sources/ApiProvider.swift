//
//  ApioProvider.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 19/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public enum ApiProviderError: Error {
    case invalidURL
    case network(Error?)
    case parsingError
    case invalidImage
    case noData
}

public protocol ApiProvider {
    func request<T>(_ endpoint: Endpoint<T>, then handler: @escaping (Result<T>) -> Void)
}
