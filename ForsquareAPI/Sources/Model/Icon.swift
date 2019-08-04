//
//  Icon.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

struct Photos: Codable {
    let count: Int
    let groups: [JSONAny]
}

struct Icon: Codable {
    let prefix: String
    let suffix: Suffix
}

enum Suffix: String, Codable {
    case png = ".png"
    case jpeg = ".jpeg"
}

struct IconURL: Codable {
    let prefix: String
    let sizes: [Int]
    let name: String
}
