//  LockTests.swift
//  Created by Igor Manakov on 07.03.2024.

import XCTest
import Combine
@testable import Logic

final class LockTests: XCTestCase {
    let sut = Lock()

    func testLock_ChangingBoolFlag_PassSignal() throws {
        let param = Wrapped.string("Hello")

        let paramSubject = CurrentValueSubject<Wrapped, Never>(.string(nil))
        let paramSubject2 = CurrentValueSubject<Wrapped, Never>(.bool(nil))

        sut.linkInput(paramSubject, position: 0)
        sut.linkInput(paramSubject2, position: 1)

        paramSubject.send(param)

        XCTAssertNil(sut.output.value.string)

        paramSubject2.send(.bool(true))

        XCTAssertEqual(sut.output.value.string, param.string)

        paramSubject2.send(.bool(false))

        XCTAssertNil(sut.output.value.string)
    }

    func testLock_Remove_ClearsOutput() throws {
        let paramSubject = CurrentValueSubject<Wrapped, Never>(.string("Hello"))
        let paramSubject2 = CurrentValueSubject<Wrapped, Never>(.bool(true))


        sut.linkInput(paramSubject, position: 0)
        sut.linkInput(paramSubject2, position: 1)

        XCTAssertEqual(sut.output.value.string, paramSubject.value.string)

        sut.remove()

        XCTAssertNil(sut.output.value.string)
        XCTAssertNotNil(paramSubject.value.string)
    }

    func testLock_LinkInput_WrongType_ReturnsFalse() throws {
        XCTAssertFalse(sut.linkInput(.init(.bool(nil)), position: 0))
        XCTAssertFalse(sut.linkInput(.init(.string(nil)), position: 1))
    }

    func testLock_LinkInput_WrongPosition_ReturnsFalse() throws {
        XCTAssertFalse(sut.linkInput(.init(.string(nil)), position: -1))
    }

    func testLock_HasAllowedOutputs() throws {
        XCTAssertNotEqual(sut.allowedOutputTypes(0).count, 0)
        XCTAssertEqual(sut.allowedOutputTypes(-1).count, 0)
    }
}

