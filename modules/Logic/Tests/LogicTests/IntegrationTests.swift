//  IntegrationTests.swift
//  Created by Vladimir Roganov on 21.02.2024

import XCTest
import Combine
@testable import Logic

final class IntegrationTests: XCTestCase {
    func testTwoRandomLettersJoined_OutputsCorrectStringLength() throws {
        let randomLetter = RandomLetter()
        let join = Join()

        join.linkInput(randomLetter.output, position: 0)
        join.linkInput(randomLetter.output, position: 1)

        randomLetter.run()

        XCTAssertEqual(join.output.value.string?.count, 2)
    }
}
