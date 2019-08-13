//
//  Icon.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

public struct Photos: Codable {
    public let count: Int
    public let groups: [JSONAny]
}

public struct Icon: Codable {
    public let prefix: String
    public let suffix: Suffix
}

public enum Suffix: String, Codable {
    case png = ".png"
    case jpeg = ".jpeg"
}

public struct IconURL: Codable {
    public let prefix: String
    public let sizes: [Int]
    public let name: String
}
