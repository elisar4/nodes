//  NodesTests.swift
//  Created by Vladimir Roganov on 21.02.2024

import XCTest
@testable import Logic

import Combine

final class NodesTests: XCTestCase {
    private var listeners: Set<AnyCancellable> = .init()

    func testRandomLetter_OuputsSingleLetter() throws {
        let sut = RandomLetter()

        var output: String?
        sut.output.sink {
            output = $0
        }.store(in: &listeners)

        sut.run()

        XCTAssertEqual(output?.count, 1)
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

        var output: String?
        sut.output.sink {
            output = $0
        }.store(in: &listeners)

        paramSubject.send(param)

        XCTAssertEqual(param, output)
    }

    func testJoin_WithBothParams_OneWithoutSend_NotOutputsParamString() throws {
        let sut = Join()

        let paramA = "A"
        let paramB = "B"
        let constStringNodeA = ConstantString(paramA)
        let constStringNodeB = ConstantString(paramB)

        sut.linkParamOne(constStringNodeA.output)
        sut.linkParamTwo(constStringNodeB.output)

        var output: String?
        sut.output.sink {
            output = $0
        }.store(in: &listeners)

        constStringNodeA.run()

        XCTAssertEqual(paramA, output)
    }

    func testJoin_WithBothParams_OutputsCombinedString() throws {
        let sut = Join()
        let param = "Hello"
        let param2 = "World"

        let paramSubject = CurrentValueSubject<String?, Never>(nil)
        sut.linkParamOne(paramSubject)
        let param2Subject = CurrentValueSubject<String?, Never>(nil)
        sut.linkParamTwo(param2Subject)

        var output: String?
        sut.output.sink {
            output = $0
        }.store(in: &listeners)

        paramSubject.send(param)
        param2Subject.send(param2)

        XCTAssertEqual(output, param + param2)
    }

    func testDisplay_OutputsAndPrintReceivedValue() throws {
        let sut = Display()
        let param = "Hello"

        let paramSubject = CurrentValueSubject<String?, Never>(nil)

        sut.linkInput(paramSubject)

        var output: String?
        sut.output.sink {
            output = $0
        }.store(in: &listeners)

        var printedValue: String?
        sut.action = {
            printedValue = $0
        }

        paramSubject.send(param)

        XCTAssertEqual(output, param)
        XCTAssertEqual(printedValue, param)
    }

    func testTwoRandomLettersJoined_OutputsCorrectStringLength() throws {
        let sut = RandomLetter()
        let sut2 = Join()

        sut2.linkParamOne(sut.output)
        sut2.linkParamTwo(sut.output)

        var output: String?
        sut2.output.sink {
            output = $0
        }.store(in: &listeners)

        sut.run()

        XCTAssertEqual(output?.count, 2)
    }
}

