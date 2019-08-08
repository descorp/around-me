//
//  RootViewModel.swift
//  AroundMe
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import Combine
import ForsquareAPI

class RootViewModel: ObservableObject {
    @Published var venuse: [VenueModel] = []
    @Published var categories: [CategoryModel] = []
}
