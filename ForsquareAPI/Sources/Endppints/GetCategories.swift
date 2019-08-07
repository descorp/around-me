//
//  GetCategories.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import ApiProvider

struct CategoriesResponse: Codable {
    let categories: [Category]
}

extension Endpoint where ReturnType == FoursquareResponce<CategoriesResponse> {
    static func getCategories() -> Endpoint {
        return Endpoint(
            path: "/venues/categories",
            body: nil,
            queryItems: [],
            parse: ReturnType.decode
        )
    }
}
