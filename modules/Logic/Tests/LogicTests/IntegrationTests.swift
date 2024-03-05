//  IntegrationTests.swift
//  Created by Vladimir Roganov on 21.02.2024

import XCTest
import Combine
@testable import Logic

final class IntegrationTests: XCTestCase {
    private var listeners: Set<AnyCancellable> = .init()

    func testTwoRandomLettersJoined_OutputsCorrectStringLength() throws {
        let sut1 = RandomLetter()
        let sut2 = Join()

        sut2.linkInput(sut1.output, position: 0)
        sut2.linkInput(sut1.output, position: 1)

        var result: Wrapped?
        sut2.output.sink {
            result = $0
        }.store(in: &listeners)

        sut1.run()

        XCTAssertEqual(result?.string?.count, 2)
    }
}
