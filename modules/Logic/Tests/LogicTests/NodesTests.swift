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
        
        
        sut.output.collect(2).sink {
            letter1 = $0.first
            letter2 = $0.last
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
        sut.input(firstParam: param, lastParam: nil)
        XCTAssertEqual(sut.output(), param)
    }
    
    func testJoin_WithBothParams_OutputsCombinedString() throws {
        let sut = Join()
        let param = "Hello"
        let param2 = "World"
        sut.input(firstParam: param, lastParam: param2)
        XCTAssertEqual(sut.output(), param + param2)
    }
    
    func testDisplay_OutputsReceivedValue() throws {
        let sut = Display()
        XCTAssertNil(sut.output())
        let param = "Hello"
        sut.input(param)
        XCTAssertEqual(sut.output(), param)
    }
    
    func testDisplay_PrintsReceivedValue() throws {
        let sut = Display()
        let inputValue = "Hello"
        var printedValue: String?
        sut.action = {
            printedValue = $0
        }
        sut.input(inputValue)
        XCTAssertEqual(printedValue, inputValue)
    }
}
