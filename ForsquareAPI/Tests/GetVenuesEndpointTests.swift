//
//  GetVenuesEndpointTests.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 04/08/2019.
//

import XCTest
import ApiProvider
@testable import ForsquareAPI

final class GetVenuesEndpointTests: XCTestCase {
    
    let urlBuilder = ForsquareUrlRequestBuilder(with: Configuration(bundle: Bundle(for: GetVenuesEndpointTests.self)))
    let coordinates = Coordinates(lat: 52.313388, lng:  5.037687)
    
    func testGetVenueUrl() {
        let sut = Endpoint.getVenues(at: coordinates, radius: 1000, categories: .metro, .bikeRental, .busStop)
        XCTAssertEqual(try urlBuilder.buildRequest(for: sut).url!.absoluteString,
    "https://api.foursquare.com/v2/venues/search?ll=52.313388,5.037687&radius=1000&categoryId=4bf58dd8d48988d1fd931735,4e4c9077bd41f78e849722f9,52f2ab2ebcbc57f1066b8b4f&client_id=CLIENT_ID&client_secret=CLIENT_SECRET&v=20190804")
    }
    
    func testDataSampleParsing() {
        let sut = Endpoint.getVenues(at: coordinates, radius: 1000, categories: .metro, .bikeRental, .busStop)
        let dataProvider = LocalApiProvider(bundle: Bundle(for: GetVenuesEndpointTests.self), localPath: "SampleData")
        dataProvider.request(sut) { (result) in
            if case let Result.success(response) = result {
                XCTAssertNotNil(response)
                XCTAssertEqual(response.response.venues.count, 4)
            } else {
                XCTFail("Parsing not successfull")
            }
        }
    }
}
