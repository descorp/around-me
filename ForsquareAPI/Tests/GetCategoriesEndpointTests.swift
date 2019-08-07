//
//  GetCategoriesTests.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 07/08/2019.
//

import Foundation

import XCTest
import ApiProvider
@testable import ForsquareAPI

final class GetCategoriesEndpointTests: XCTestCase {
    
    let urlBuilder = ForsquareUrlRequestBuilder(with: Configuration(bundle: Bundle(for: GetVenuesEndpointTests.self)))
    
    func testGetVenueUrl() {
        let sut = Endpoint.getCategories()
        XCTAssertEqual(try urlBuilder.buildRequest(for: sut).url!.absoluteString,
    "https://api.foursquare.com/v2/venues/categories?client_id=CLIENT_ID&client_secret=CLIENT_SECRET&v=20190804")
    }
    
    func testDataSampleParsing() {
        let sut = Endpoint.getCategories()
        let dataProvider = LocalApiProvider(bundle: Bundle(for: GetVenuesEndpointTests.self), localPath: "SampleData")
        dataProvider.request(sut) { (result) in
            if case let Result.success(fullResponse) = result {
                XCTAssertNotNil(fullResponse)
                XCTAssertEqual(fullResponse.response.categories.count, 10)
            } else {
                XCTFail("Parsing not successfull")
            }
        }
    }
    
}
