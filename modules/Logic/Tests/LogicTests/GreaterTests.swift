//  GreaterTests.swift
//  Created by Vladimir Roganov on 07.03.2024

import XCTest
import Combine
@testable import Logic

final class GreaterTests: XCTestCase {
    let sut = Greater()

    func testGreater_WithoutInputs_ProvideNilOutput() throws {
        XCTAssertNil(sut.output1.value.bool)
        XCTAssertNil(sut.output2.value.bool)
    }

    func testGreater_WithOneInput_ProvideNilOutput() throws {
        setupSUT(1)
        XCTAssertNil(sut.output1.value.bool)
        XCTAssertNil(sut.output2.value.bool)
    }

    func testGreater_WithInput1GreaterThanInput2_ProvideOutput1TrueOutput2False() throws {
        setupSUT(1, -1)
        let result1 = try XCTUnwrap(sut.output1.value.bool)
        let result2 = try XCTUnwrap(sut.output2.value.bool)
        XCTAssertTrue(result1)
        XCTAssertFalse(result2)
    }

    func testGreater_WithInput1LessThanInput2_ProvideOutput1FalseOutput2True() throws {
        setupSUT(1, 2)
        let result1 = try XCTUnwrap(sut.output1.value.bool)
        let result2 = try XCTUnwrap(sut.output2.value.bool)
        XCTAssertFalse(result1)
        XCTAssertTrue(result2)
    }

    func testGreater_Remove_ClearsOutput() throws {
        let (input1, _) = setupSUT(10, 2)
        XCTAssertTrue(sut.output1.value.bool == true)
        sut.remove()
        XCTAssertNil(sut.output1.value.bool)
        XCTAssertNil(sut.output2.value.bool)
        input1.send(.int(5))
        XCTAssertNil(sut.output1.value.bool)
        XCTAssertNil(sut.output2.value.bool)
    }

    func testGreater_LinkInput_WrongType_ReturnsFalse() throws {
        XCTAssertFalse(sut.linkInput(.init(.bool(nil)), position: 0))
        XCTAssertFalse(sut.linkInput(.init(.string(nil)), position: 1))
    }

    func testGreater_LinkInput_WrongPosition_ReturnsFalse() throws {
        XCTAssertFalse(sut.linkInput(.init(.int(nil)), position: -1))
    }

    func testGreater_HasAllowedOutputs() throws {
        XCTAssertNotEqual(sut.allowedOutputTypes(0).count, 0)
        XCTAssertEqual(sut.allowedOutputTypes(-1).count, 0)
    }

    @discardableResult
    private func setupSUT(_ value1: Int? = nil, _ value2: Int? = nil) -> (CurrentValueSubject<Wrapped, Never>, CurrentValueSubject<Wrapped, Never>) {
        let input1 = CurrentValueSubject<Wrapped, Never>(.int(value1))
        let input2 = CurrentValueSubject<Wrapped, Never>(.int(value2))
        _ = sut.linkInput(input1, position: 0)
        _ = sut.linkInput(input2, position: 1)
        return (input1, input2)
    }
}
