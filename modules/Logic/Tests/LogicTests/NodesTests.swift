//  NodesTests.swift
//  Created by Vladimir Roganov on 21.02.2024

import XCTest
import Combine
@testable import Logic

final class NodesTests: XCTestCase {
    private var listeners: Set<AnyCancellable> = .init()

    func testRandomLetter_OuputsSingleLetter() throws {
        let sut = RandomLetter()

        var result: String?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        sut.run()

        XCTAssertEqual(result?.count, 1)
    }

    func testRandomLetter_OutputsDifferentRandomLetters() throws {
        let sut = RandomLetter()

        var letter1: String?
        var letter2: String?
        sut.output.collect(2).sink { value in
            letter1 = value.first ?? nil
            letter2 = value.last ?? nil
        }.store(in: &listeners)

        sut.run()
        sut.run()

        XCTAssertNotEqual(letter1, letter2)
    }

    func testJoin_OutputsEmptyString_WithoutParams() throws {
        XCTAssertNotNil(Join().output.value)
    }

    func testJoin_WithSingleParam_OutputsParamString() throws {
        let sut = Join()
        let param = "Hello"

        let paramSubject = CurrentValueSubject<String?, Never>(nil)
        sut.linkParamOne(paramSubject)

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

        sut.linkParamOne(constStringNodeA.output)
        sut.linkParamTwo(constStringNodeB.output)

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
        sut.linkParamOne(param1Subject)
        let param2Subject = CurrentValueSubject<String?, Never>(nil)
        sut.linkParamTwo(param2Subject)

        var result: String?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        param1Subject.send(param1)
        param2Subject.send(param2)

        XCTAssertEqual(result, param1 + param2)
    }

    func testDisplay_OutputsAndPrintReceivedValue() throws {
        let sut = Display()
        let param = "Hello"

        let paramSubject = CurrentValueSubject<String?, Never>(nil)

        sut.linkInput(paramSubject)

        var result: String?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        var printedValue: String?
        sut.action = {
            printedValue = $0
        }

        paramSubject.send(param)

        XCTAssertEqual(result, param)
        XCTAssertEqual(printedValue, param)
    }

    func testTwoRandomLettersJoined_OutputsCorrectStringLength() throws {
        let sut1 = RandomLetter()
        let sut2 = Join()

        sut2.linkParamOne(sut1.output)
        sut2.linkParamTwo(sut1.output)

        var result: String?
        sut2.output.sink {
            result = $0
        }.store(in: &listeners)

        sut1.run()

        XCTAssertEqual(result?.count, 2)
    }
}
