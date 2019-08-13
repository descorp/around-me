//
//  InitScene.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 10/08/2019.
//

import Combine
import SwiftUI
import FoursquareAPI

protocol InitViewModelDelegate: class {
    func didLoadCategories(_ categories: [FoursquareAPI.Category])
    func didFail(_ error: Error)
}

class InitViewModel: ObservableObject {
    private var categoryUpdateSubscription: AnyCancellable?
    private let categoryLoader: CategoryLoader
    
    weak var delegate: InitViewModelDelegate?
    
    @Published public var isLoading = false
    
    internal init(categoryLoader: CategoryLoader) {
        self.categoryLoader = categoryLoader
        
         categoryUpdateSubscription = categoryLoader.didChange
            .delay(for: DispatchQueue.SchedulerTimeType.Stride(integerLiteral: 2), scheduler: DispatchQueue.global())
            .sink(receiveCompletion: {
                self.receive(completion: $0)
            }, receiveValue: {
                self.receive($0)
            })
    }
    
    func loadData() {
        self.isLoading = true
        categoryLoader.getCategories()
    }
    
    func receive(_ input: [FoursquareAPI.Category]) {
        DispatchQueue.main.async {
            self.isLoading = false
        }
        delegate?.didLoadCategories(input)
    }
    
    func receive(completion: Subscribers.Completion<Error>) {
        self.isLoading = false
        switch completion {
        case .failure(let error):
            delegate?.didFail(error)
        default: break
        }
    }
}
