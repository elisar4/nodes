//  JoinTests.swift
//  Created by Igor Manakov on 04.03.2024.

import XCTest
import Combine
@testable import Logic

final class JoinTests: XCTestCase {
    private var listeners: Set<AnyCancellable> = .init()

    func testJoin_OutputsEmptyString_WithoutParams() throws {
        XCTAssertNotNil(Join().output.value)
    }

    func testJoin_WithSingleParam_OutputsParamString() throws {
        let sut = Join()
        let param = "Hello"

        let paramSubject = CurrentValueSubject<String?, Never>(nil)
        sut.linkInput(paramSubject, position: 0)

        var result: String?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        paramSubject.send(param)

        XCTAssertEqual(param, result)
    }

    func testJoin_WithBothParams_OneWithoutSend_NotOutputsParamString() throws {
        let sut = Join()

        let paramA = "A"
        let paramB = "B"
        let constStringNodeA = ConstantString(paramA)
        let constStringNodeB = ConstantString(paramB)

        sut.linkInput(constStringNodeA.output, position: 0)
        sut.linkInput(constStringNodeB.output, position: 1)

        var result: String?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        constStringNodeA.run()

        XCTAssertEqual(paramA, result)
    }

    func testJoin_WithBothParams_OutputsCombinedString() throws {
        let sut = Join()
        let param1 = "Hello"
        let param2 = "World"

        let param1Subject = CurrentValueSubject<String?, Never>(nil)
        sut.linkInput(param1Subject, position: 0)
        let param2Subject = CurrentValueSubject<String?, Never>(nil)
        sut.linkInput(param2Subject, position: 1)

        var result: String?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        param1Subject.send(param1)
        param2Subject.send(param2)

        XCTAssertEqual(result, param1 + param2)
    }
}
