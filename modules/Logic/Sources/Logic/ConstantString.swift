//  ConstantString.swift
//  Created by Aiur Arkhipov on 27.02.2024.

import Combine

public class ConstantString {
    public var output: CurrentValueSubject<Wrapped, Never> = .init(.string(nil))

    private var string: String

    public init(_ string: String) {
        self.string = string
    }

    public func run() {
        output.send(.string(string))
    }
}
