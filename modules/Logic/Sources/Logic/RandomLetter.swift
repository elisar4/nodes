//  RandomLetter.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public class RandomLetter {
    public var output: CurrentValueSubject<Wrapped?, Never> = .init(nil)

    public init() {}

    public func run() {
        let chars = "ABCDEFGHIJQKLMNOPRSTUVWXYZ".map({ $0 })
        output.send(.string(chars[Int.random(in: 0...25)].description))
    }

    public func remove() {
        output.send(nil)
    }
}
