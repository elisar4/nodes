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
}
