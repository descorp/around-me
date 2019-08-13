//
//  Groups.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

struct Group: Codable {
    let type, name: String
    let items: [GroupItem]
}

struct GroupItem: Codable {
    let reasons: Reasons
    let venue: Venue
    let referralID: String
    
    enum CodingKeys: String, CodingKey {
        case reasons, venue
        case referralID = "referralId"
    }
}

struct Reasons: Codable {
    let count: Int
    let items: [ReasonsItem]
}

struct ReasonsItem: Codable {
    let summary, type, reasonName: String
}
