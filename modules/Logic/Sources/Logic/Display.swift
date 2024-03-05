//  Display.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public final class Display: NodeInput {
    public var input: AnyPublisher<Wrapped?, Never> = CurrentValueSubject.init(.string("")).eraseToAnyPublisher()
    public var output: CurrentValueSubject<Wrapped?, Never> = .init(.string(""))

    public var action: ((_: String?) -> Void)? = {
        print($0 ?? "nil")
    }

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
            .sink { [weak self] input in
                self?.output.send(input)
                self?.action?(input?.string ?? input?.int?.description)
            }
    }
}
