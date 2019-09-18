import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MTDBlogImageRequestTests.allTests),
    ]
}
#endif
