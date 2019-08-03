//
//  Endpoint.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 19/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

public struct Endpoint<T> {
    public var body: Data?    
    public let path: String
    public let queryItems: [URLQueryItem]
    public let parse: (Data) throws -> T
    
    public init(path: String, body: Data? = nil, queryItems: [URLQueryItem] = [], parse: @escaping (Data) throws -> T) {
        self.path = path
        self.body = body
        self.queryItems = queryItems
        self.parse = parse
    }
}
