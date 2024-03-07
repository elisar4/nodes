//  Count.swift
//  Created by Igor Manakov on 04.03.2024.

import Combine

public final class Count: NodeInput {
    public var input: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.string(nil)).eraseToAnyPublisher()
    public var output: CurrentValueSubject<Wrapped, Never> = .init(.int(nil))

    private var listener: AnyCancellable?

    let allowedTypes: [Int: [String]] = [
        0: ["s"],
    ]

    public init() {}

    public func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool {
        guard position == 0 else {
            return false
        }
        guard allowedTypes[position]?.contains(input.value.type) == true else {
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

    private func linkInput(_ link: CurrentValueSubject<Wrapped, Never>) {
        input = link.eraseToAnyPublisher()
        listener = input
            .sink { [weak output] input in
                output?.send(.int(input.string?.count ?? 0))
            }
    }
}
