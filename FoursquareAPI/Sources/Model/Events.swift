//
//  Events.swift
//  ForsquareLib
//
//  Created by Vladimir Abramichev on 25/02/2019.
//

import Foundation

public struct Events: Codable {
    public let count: Int
    public let summary: String
    public let items: [EventsItem]
}

public struct EventsItem: Codable {
    public let id, name: String
    public let categories: [Category]
    public let startAt, endAt: Int
    public let allDay: Bool
    public let timeZone, text: String
    public let url: String
    public let images: [JSONAny]
    public let provider: Provider
    public let stats: Stats
}

public struct Stats: Codable {
    public let checkinsCount, usersCount: Int
}

public struct Provider: Codable {
    public let name: String
    public let iconURL: IconURL
    public let urlText: String
    
    public enum CodingKeys: String, CodingKey {
        case name
        case iconURL = "iconUrl"
        case urlText
    }
}
