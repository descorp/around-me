//
//  Parsable.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 18/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

public extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

public extension Decodable {
    static func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
