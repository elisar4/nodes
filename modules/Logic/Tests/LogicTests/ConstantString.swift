//  ConstantString.swift
//  Created by Aiur Arkhipov on 27.02.2024.

import Combine
@testable import Logic

class ConstantString {
    var output: CurrentValueSubject<Wrapped, Never> = .init(.string(nil))

    private var string: String

    init(_ string: String) {
        self.string = string
    }

    func run() {
        output.send(.string(string))
    }
}
