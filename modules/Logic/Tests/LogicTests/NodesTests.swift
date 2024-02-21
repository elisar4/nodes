//  NodesTests.swift
//  Created by Vladimir Roganov on 21.02.2024

import XCTest
@testable import Logic

final class NodesTests: XCTestCase {
    func testRandomLetter_OuputsSingleLetter() throws {
        let sut = RandomLetter()
        XCTAssertEqual(sut.output().count, 1)
    }

    func testRandomLetter_OutputsDifferentRandomLetters() throws {
        let sut = RandomLetter()
        let letter1 = sut.output()
        let letter2 = sut.output()
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
}
