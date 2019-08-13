//
//  CategoryService.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import Foundation
import Combine
import FoursquareAPI
import ApiProvider

protocol CategoryLoader {
    func getCategories()
    var didChange: PassthroughSubject<[FoursquareAPI.Category], Error> { get }
}

class CategoryLoaderImplementation: CategoryLoader {
    private let apiProvider: ApiProvider
    var didChange = PassthroughSubject<[FoursquareAPI.Category], Error>()
    
    init(provider: ApiProvider) {
        self.apiProvider = provider
    }
    
    func getCategories() {
        apiProvider.request(Endpoint.getCategories()) { response in
            switch response {
            case .success(let result):
                self.didChange.send(result.response.categories)
            case .failure(let error):
                var proccessedError = error
                if case ApiProviderError.response(code: let code, message: let message) = error {
                    proccessedError = NSError(domain: NSURLErrorDomain,
                                              code: code,
                                              userInfo: [NSLocalizedDescriptionKey: message ?? ""])
                }
                self.didChange.send(completion: Subscribers.Completion<Error>.failure(proccessedError))
            }
        }
    }
}
