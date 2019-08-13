import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FoursquareAPITests.allTests),
    ]
}
#endif
