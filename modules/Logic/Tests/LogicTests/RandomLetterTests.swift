//  RandomLetterTests.swift
//  Created by Igor Manakov on 04.03.2024.

import XCTest
import Combine
@testable import Logic

final class RandomLetterTests: XCTestCase {
    let sut = RandomLetter()
    private var listeners: Set<AnyCancellable> = .init()

    func testRandomLetter_OuputsSingleLetter() throws {
        sut.run()
        XCTAssertEqual(sut.output.value.string?.count, 1)
    }

    func testRandomLetter_OutputsDifferentRandomLetters() throws {
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
