//
//  ApiProviderTests.swift
//  ApiProviderTests
//
//  Created by Vladimir Abramichev on 19/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import XCTest

#if os(OSX)
@testable import ApiProviderMac
#elseif os(iOS)
@testable import ApiProvider
#endif


class LondonMetroApiProviderTests: XCTestCase {
    
    var apiProvider: RemoteApiProvider!

    override func setUp() {
        apiProvider = RemoteApiProvider(with: LondonMetroUrlBuilder())
    }

    override func tearDown() {
        apiProvider = nil
    }

    func testGetBikePoint() {
        let successExpectation = expectation(description: "Success")
        let bikePointId = "BikePoints_3"
        apiProvider.request(Endpoint.bikePoint(id: bikePointId)) { result in
            if case .success(let responce) = result {
                XCTAssertNotNil(responce)
                XCTAssertEqual(responce.id, bikePointId)
                successExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

struct Dummy: Codable {
    var id: String
}

class LondonMetroUrlBuilder: RequestBuilder {
    func buildRequest<T>(for endpoint: Endpoint<T>) -> URLRequest? {
        var baseUrl = URL(string: "https://api.tfl.gov.uk")!
        baseUrl.appendPathComponent(endpoint.path)
        return URLRequest(url: baseUrl)
    }
}

extension Endpoint where T == Dummy {
    static func bikePoint(id: String) -> Endpoint {
        return Endpoint(
            path: "/BikePoint/\(id)", body: nil,
            queryItems: [],
            parse: T.decode
        )
    }
}
