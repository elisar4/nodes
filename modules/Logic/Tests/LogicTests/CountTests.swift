//  CountTests.swift
//  Created by Igor Manakov on 04.03.2024.

import XCTest
import Combine
@testable import Logic

final class CountTests: XCTestCase {
    let sut = Count()

    func testCount_OutputsNil_WithoutInput() throws {
        XCTAssertNil(sut.output.value.int)
    }

    func testCount_OutputsCorrectInputLength() throws {
        let param = "Hello, world!"

        let paramSubject = CurrentValueSubject<Wrapped, Never>(.string(nil))
        sut.linkInput(paramSubject, position: 0)
        paramSubject.send(.string(param))

        XCTAssertEqual(sut.output.value.int, param.count)
    }
}
