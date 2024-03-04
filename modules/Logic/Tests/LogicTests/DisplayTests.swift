//  DisplayTests.swift
//  Created by Igor Manakov on 04.03.2024.

import XCTest
import Combine
@testable import Logic

final class DisplayTests: XCTestCase {
    private var listeners: Set<AnyCancellable> = .init()

    func testDisplay_OutputsAndPrintReceivedValue() throws {
        let sut = Display()
        let param = Wrapped.string("Hello")

        let paramSubject = CurrentValueSubject<Wrapped?, Never>(nil)

        sut.linkInput(paramSubject, position: 0)

        var result: Wrapped?
        sut.output.sink {
            result = $0
        }.store(in: &listeners)

        var printedValue: Wrapped?
        sut.action = {
            printedValue = .string($0 ?? "")
        }

        paramSubject.send(param)

        XCTAssertEqual(result, param)
        XCTAssertEqual(printedValue, param)
    }
}
