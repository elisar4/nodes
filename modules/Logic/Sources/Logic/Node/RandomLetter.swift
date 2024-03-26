//  RandomLetter.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public class RandomLetter: NodeModel {
    public func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool { false }
    
    public var output: CurrentValueSubject<Wrapped, Never> = .init(.string(nil))

    private let inputTypes: [Int: [String]] = [:]

    private let outputTypes: [Int: [String]] = [
        0: ["s"],
    ]

    public init() {}

    public func run() {
        let chars = "ABCDEFGHIJQKLMNOPRSTUVWXYZ".map({ $0 })
        output.send(.string(chars[Int.random(in: 0...25)].description))
    }

    public func getOutput(_ position: Int) -> CurrentValueSubject<Wrapped, Never>? {
        if position == 0 {
            return output
        }
        return nil
    }

    public var inputsCount: Int {
        return inputTypes.keys.count
    }

    public var outputsCount: Int {
        return outputTypes.keys.count
    }

    public func remove() {
        output.send(.string(nil))
    }

    public func allowedInputTypes(_ position: Int) -> [String] {
        inputTypes[position] ?? []
    }

    public func allowedOutputTypes(_ position: Int) -> [String] {
        outputTypes[position] ?? []
    }
}
