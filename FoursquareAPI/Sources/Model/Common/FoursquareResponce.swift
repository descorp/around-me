//
//  FoursquareResponce.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

public struct FoursquareResponce<T: Codable>: Codable {
    public let meta: Meta
    public let response: T
}
