import XCTest
import MultiserverAddress

final class MultiserverAddressTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MultiserverAddress().text, "Hello, World!")
    }
}

static let allTests = [
    ("testExample", testExample),
]