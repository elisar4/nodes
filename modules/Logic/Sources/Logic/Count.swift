//  Count.swift
//  Created by Igor Manakov on 04.03.2024.

import Combine

public final class Count: NodeInput {
    public var input: AnyPublisher<Wrapped?, Never> = CurrentValueSubject.init(.string("")).eraseToAnyPublisher()
    public var output: CurrentValueSubject<Wrapped?, Never> = .init(.int(0))

    private var listener: AnyCancellable?

    public init() {}

    public func linkInput(_ input: CurrentValueSubject<Wrapped?, Never>, position: Int) {
        if position == 0 {
            linkInput(input)
        }
    }

    public func remove() {
        output.send(nil)
        listener = nil
    }

    private func linkInput(_ link: CurrentValueSubject<Wrapped?, Never>) {
        input = link.eraseToAnyPublisher()
        listener = input
            .sink { [weak output] input in
                output?.send(.int(input?.string?.count ?? 0))
            }
    }
}
