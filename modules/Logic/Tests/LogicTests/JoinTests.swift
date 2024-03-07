//  JoinTests.swift
//  Created by Igor Manakov on 04.03.2024.

import XCTest
import Combine
@testable import Logic

final class JoinTests: XCTestCase {
    let sut = Join()

    func testJoin_OutputsEmptyString_WithoutParams() throws {
        XCTAssertNotNil(sut.output.value)
    }

    func testJoin_WithSingleParam_OutputsParamString() throws {
        let param = "Hello"

        let paramSubject = CurrentValueSubject<Wrapped, Never>(.string(nil))
        sut.linkInput(paramSubject, position: 0)

        paramSubject.send(.string(param))

        XCTAssertEqual(sut.output.value, .string(param))
    }

    func testJoin_WithBothParams_OneWithoutSend_NotOutputsParamString() throws {
        let paramA = "A"
        let paramB = "B"
        let constStringNodeA = ConstantString(paramA)
        let constStringNodeB = ConstantString(paramB)

        sut.linkInput(constStringNodeA.output, position: 0)
        sut.linkInput(constStringNodeB.output, position: 1)

        constStringNodeA.run()

        XCTAssertEqual(sut.output.value, .string(paramA))
    }

    func testJoin_WithBothParams_OutputsCombinedString() throws {
        let param1 = "Hello"
        let param2 = "World"

        let param1Subject = CurrentValueSubject<Wrapped, Never>(.string(nil))
        sut.linkInput(param1Subject, position: 0)
        let param2Subject = CurrentValueSubject<Wrapped, Never>(.string(nil))
        sut.linkInput(param2Subject, position: 1)

        param1Subject.send(.string(param1))
        param2Subject.send(.string(param2))

        XCTAssertEqual(sut.output.value, .string(param1 + param2))
    }
}
