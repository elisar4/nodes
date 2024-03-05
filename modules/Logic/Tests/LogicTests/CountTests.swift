//  CountTests.swift
//  Created by Igor Manakov on 04.03.2024.

import XCTest
import Combine
@testable import Logic

final class CountTests: XCTestCase {
    private var listeners: Set<AnyCancellable> = .init()

    func testCount_OutputsNil_WithoutInput() throws {
        XCTAssertNil(Count().output.value?.int)
    }

    func testCount_OutputsCorrectInputLength() throws {
        let sut = Count()
        let param = "Hello, world!"

        let paramSubject = CurrentValueSubject<Wrapped?, Never>(nil)

        sut.linkInput(paramSubject, position: 0)

        var result: Wrapped?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        paramSubject.send(.string(param))

        XCTAssertEqual(result?.int, param.count)
    }
}
