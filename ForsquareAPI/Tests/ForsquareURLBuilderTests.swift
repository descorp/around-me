//
//  GetVenuesEndpointTests.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 04/08/2019.
//

import XCTest
import ApiProvider
@testable import ForsquareAPI

final class ForsquareAPITests: XCTestCase {
    
    let coordinates = Coordinates(lat: 52.313388, lng:  5.037687)
    
    func testCoordinateQuery() {
        let sut = Endpoint.geyVenues(at: coordinates)
        
        XCTAssertEqual(sut.queryItems[0].value, "52.313388,5.037687")
    }
    
    func testCategoryQuery() {
        let sut = Endpoint.geyVenues(at: coordinates, categories: .metro, .food)
        
        XCTAssertEqual(sut.queryItems[2].value!, "4bf58dd8d48988d1fd931735,4d4b7105d754a06374d81259")
    }
    
    func testUrlBuilderConfiguredFromCustomDictionary() {
        let sut = ForsquareUrlRequestBuilder(with: Configuration(dictionary: ["client_id":"SOME_CLIENT_ID",
                                                                              "client_secret":"SOME_CLIENT_SECRET",
                                                                              "url":"http://SOME_URL.com",
                                                                              "version":"v5",
                                                                              "version_date":"SOME_VERSION_DATE"]))
        XCTAssertEqual(try sut.buildRequest(for: Endpoint.test()).url!.absoluteString,
                       "http://SOME_URL.com/v5/testURL?client_id=SOME_CLIENT_ID&client_secret=SOME_CLIENT_SECRET&v=SOME_VERSION_DATE")
    }
    
    func testUrlBuilderConfiguredFromConfigFile() {
        let sut = ForsquareUrlRequestBuilder(with: Configuration(bundle: Bundle(for: type(of: self))))
        XCTAssertEqual(try sut.buildRequest(for: Endpoint.test()).url!.absoluteString,
        "https://api.foursquare.com/v2/testURL?client_id=CLIENT_ID&client_secret=CLIENT_SECRET&v=20190804")
    }

    static var allTests = [
        ("testExample", testCoordinateQuery),
    ]
}

struct Dummy: Codable { }

extension Endpoint where ReturnType == Dummy {
    static func test() -> Endpoint {
        return Endpoint(
            path: "testURL",
            body: nil,
            queryItems: [],
            parse: ReturnType.decode
        )
    }
}
