//
//  Endpoint.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 19/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

public struct Endpoint<ReturnType> {
    public let method: String
    public let body: Data?
    public let path: String
    public let queryItems: [URLQueryItem]
    public let parse: (Data) throws -> ReturnType
    
    public init(path: String, method: String = "GET", body: Data? = nil, queryItems: [URLQueryItem] = [], parse: @escaping (Data) throws -> ReturnType) {
        self.path = path
        self.body = body
        self.queryItems = queryItems
        self.parse = parse
        self.method = method
    }
}
