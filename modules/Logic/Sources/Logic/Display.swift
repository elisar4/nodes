//  Display.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public final class Display: NodeInput {
    public var input: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
    public var output: PassthroughSubject<String?, Never> = .init()

    public var action: ((_: String?) -> Void)? = {
        print($0 ?? "nil")
    }

    private var listener: AnyCancellable?

    public init() {}

    public func linkInput(_ input: PassthroughSubject<String?, Never>, position: Int) {
        if position == 0 {
            linkInput(input)
        } else {

        }
    }

    public func linkInput(_ link: PassthroughSubject<String?, Never>) {
        input = link.eraseToAnyPublisher()
        listener = input
            .sink { [weak self] (input) in
                self?.output.send(input)
                self?.action?(input)
            }
    }
}
