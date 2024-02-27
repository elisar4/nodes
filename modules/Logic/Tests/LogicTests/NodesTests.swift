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
        let expectation = self.expectation(description: "Output")
        sut.output.sink {
            output = $0
            expectation.fulfill()
        }.store(in: &listeners)

        sut.run()

        waitForExpectations(timeout: 0.3)
        let outputString = try XCTUnwrap(output)
        XCTAssertEqual(outputString.count, 1)
    }

    func testRandomLetter_OutputsDifferentRandomLetters() throws {
        let sut = RandomLetter()

        var letter1: String?
        var letter2: String?

        let exp = self.expectation(description: "Output")

        sut.output.collect(2).sink { value in
            letter1 = value.first ?? nil
            letter2 = value.last ?? nil
            exp.fulfill()
        }.store(in: &listeners)

        sut.run()
        sut.run()

        waitForExpectations(timeout: 0.3)

        XCTAssertNotEqual(letter1, letter2)
    }

    func testJoin_OutputsEmptyString_WithoutParams() throws {
        let sut = Join()
        XCTAssertNotNil(sut.output)
    }

    func testJoin_WithSingleParam_OutputsParamString() throws {
        let sut = Join()
        let param = "Hello"

        let exp = self.expectation(description: "Output")

        var output: String?

        let paramSubject = PassthroughSubject<String?, Never>()
        sut.linkParamOne(paramSubject)

        sut.output.sink {
            output = $0
            exp.fulfill()
        }.store(in: &listeners)

        paramSubject.send(param)

        waitForExpectations(timeout: 0.3)

        XCTAssertEqual(param, output)
    }

    func testJoin_WithBothParams_OneWithoutSend_NotOutputsParamString() throws {
        let sut = Join()
        let param = "Hello"

        let exp = self.expectation(description: "Output")

        var output: String?

        let paramA = "A"
        let paramB = "B"
        let constStringNodeA = ConstantString(paramA)
        let constStringNodeB = ConstantString(paramB)

        sut.linkParamOne(constStringNodeA.output)
        sut.linkParamTwo(constStringNodeB.output)

        sut.output.sink {
            output = $0
            exp.fulfill()
        }.store(in: &listeners)

        constStringNodeA.run()

        waitForExpectations(timeout: 0.3) // Fail

        XCTAssertEqual(paramA, output)
    }

    func testJoin_WithBothParams_OutputsCombinedString() throws {
        let sut = Join()
        let param = "Hello"
        let param2 = "World"

        let exp = self.expectation(description: "Output")

        var output: String?

        let paramSubject = PassthroughSubject<String?, Never>()
        sut.linkParamOne(paramSubject)
        let param2Subject = PassthroughSubject<String?, Never>()
        sut.linkParamTwo(param2Subject)

        sut.output.sink {
            output = $0
            exp.fulfill()
        }.store(in: &listeners)

        paramSubject.send(param)
        param2Subject.send(param2)

        waitForExpectations(timeout: 0.3)

        XCTAssertEqual(output, param + param2)
    }

    func testDisplay_OutputsAndPrintReceivedValue() throws {
        let sut = Display()
        let param = "Hello"

        let exp = self.expectation(description: "Output")

        let paramSubject = PassthroughSubject<String?, Never>()

        sut.linkInput(paramSubject)

        var output: String?

        sut.output.sink {
            output = $0
            exp.fulfill()
        }.store(in: &listeners)

        var printedValue: String?

        sut.action = {
            printedValue = $0
        }

        paramSubject.send(param)

        waitForExpectations(timeout: 0.3)

        XCTAssertEqual(output, param)
        XCTAssertEqual(printedValue, param)
    }

    func testTwoRandomLettersJoined_OutputsCorrectStringLength() throws {
        let sut = RandomLetter()
        let sut2 = Join()

        let exp = self.expectation(description: "Output")

        sut2.linkParamOne(sut.output)
        sut2.linkParamTwo(sut.output)

        var output: String?

        sut2.output.sink {
            output = $0
            exp.fulfill()
        }.store(in: &listeners)

        sut.run()

        waitForExpectations(timeout: 0.3)

        XCTAssertEqual(output?.count, 2)
    }

    func testAll() throws {

    }
}

