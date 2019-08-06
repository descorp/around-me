//
//  FoursquareResponce.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

struct FoursquareResponce<T: Codable>: Codable {
    let meta: Meta
    let response: T
}