//  RandomLetterTests.swift
//  Created by Igor Manakov on 04.03.2024.

import XCTest
import Combine
@testable import Logic

final class RandomLetterTests: XCTestCase {
    private var listeners: Set<AnyCancellable> = .init()

    func testRandomLetter_OuputsSingleLetter() throws {
        let sut = RandomLetter()

        var result: Wrapped?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        sut.run()

        XCTAssertEqual(result?.string?.count, 1)
    }

    func testRandomLetter_OutputsDifferentRandomLetters() throws {
        let sut = RandomLetter()

        var letter1: Wrapped?
        var letter2: Wrapped?
        sut.output.collect(2).sink { value in
            letter1 = value.first ?? nil
            letter2 = value.last ?? nil
        }.store(in: &listeners)

        sut.run()
        sut.run()

        XCTAssertNotEqual(letter1, letter2)
    }
}
