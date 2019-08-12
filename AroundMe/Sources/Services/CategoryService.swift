//
//  CategoryService.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import Foundation
import Combine
import ForsquareAPI
import ApiProvider

protocol CategoryLoader {
    func getCategories()
    var didChange: PassthroughSubject<[ForsquareAPI.Category], Error> { get }
}

class CategoryLoaderImplementation: CategoryLoader {
    private let apiProvider: ApiProvider
    var didChange = PassthroughSubject<[ForsquareAPI.Category], Error>()
    
    init(provider: ApiProvider) {
        self.apiProvider = provider
    }
    
    func getCategories() {
        apiProvider.request(Endpoint.getCategories()) { response in
            switch response {
            case .success(let result):
                self.didChange.send(result.response.categories)
            case .failure(let error):
                self.didChange.send(completion: Subscribers.Completion<Error>.failure(error))
            }
        }
    }
}
