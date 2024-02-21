import XCTest
@testable import Logic

final class LogicTests: XCTestCase {
    func testIsRunning() throws {
        let sut = Logic()
        XCTAssertTrue(sut.running)
    }
}
