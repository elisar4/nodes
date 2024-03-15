//  Display.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public final class Display: NodeInput, Linkable {
    public var input: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.string("")).eraseToAnyPublisher()
    public var output: CurrentValueSubject<Wrapped, Never> = .init(.string(""))

    public var action: ((_: String?) -> Void)? = {
        print($0 ?? "nil")
    }

    private let inputTypes: [Int: [String]] = [
        0: ["i", "s"],
    ]

    private let outputTypes: [Int: [String]] = [
        0: ["s"],
    ]

    private var listener: AnyCancellable?

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
        output.send(.string(nil))
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
            .sink { [weak self] input in
                self?.output.send(input)
                self?.action?(input.string ?? input.int?.description)
            }
    }
}
