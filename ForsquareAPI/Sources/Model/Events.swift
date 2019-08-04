//
//  Events.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

struct Events: Codable {
    let count: Int
    let summary: String
    let items: [EventsItem]
}

struct EventsItem: Codable {
    let id, name: String
    let categories: [Category]
    let startAt, endAt: Int
    let allDay: Bool
    let timeZone, text: String
    let url: String
    let images: [JSONAny]
    let provider: Provider
    let stats: Stats
}

struct Stats: Codable {
    let checkinsCount, usersCount: Int
}

struct Provider: Codable {
    let name: String
    let iconURL: IconURL
    let urlText: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case iconURL = "iconUrl"
        case urlText
    }
}
