//  Count.swift
//  Created by Igor Manakov on 04.03.2024.

import Combine

public final class Count: NodeInput, Linkable {
    public var input: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.string(nil)).eraseToAnyPublisher()
    public var output: CurrentValueSubject<Wrapped, Never> = .init(.int(nil))

    private var listener: AnyCancellable?

    private let inputTypes: [Int: [String]] = [
        0: ["s"],
    ]

    private let outputTypes: [Int: [String]] = [
        0: ["i"],
    ]

    public init() {}

    public func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool {
        guard allowedInputTypes(position).contains(input.value.type) else {
            return false
        }
        if position == 0 {
            linkInput(input)
        }
        return true
    }

    public func remove() {
        output.send(.int(nil))
        listener = nil
    }

    public func allowedInputTypes(_ position: Int) -> [String] {
        inputTypes[position] ?? []
    }

    public func allowedOutputTypes(_ position: Int) -> [String] {
        outputTypes[position] ?? []
    }

    private func linkInput(_ link: CurrentValueSubject<Wrapped, Never>) {
        input = link.eraseToAnyPublisher()
        listener = input
            .sink { [weak output] input in
                output?.send(.int(input.string?.count ?? 0))
            }
    }
}
