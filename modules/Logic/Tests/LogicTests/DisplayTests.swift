//  DisplayTests.swift
//  Created by Igor Manakov on 04.03.2024.

import XCTest
import Combine
@testable import Logic

final class DisplayTests: XCTestCase {
    let sut = Display()

    func testDisplay_OutputsAndPrintReceivedValue() throws {
        let param = Wrapped.string("Hello")

        let paramSubject = CurrentValueSubject<Wrapped, Never>(.string(nil))

        _ = sut.linkInput(paramSubject, position: 0)

        var printedValue: Wrapped?
        sut.action = {
            printedValue = .string($0 ?? "")
        }

        paramSubject.send(param)

        XCTAssertEqual(sut.output.value, param)
        XCTAssertEqual(printedValue, param)
    }
}
