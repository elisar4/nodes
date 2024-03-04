//  Join.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public class Join: NodeInput {
    public var input1: AnyPublisher<Wrapped?, Never> = CurrentValueSubject.init(.string("")).eraseToAnyPublisher()
    public var input2: AnyPublisher<Wrapped?, Never> = CurrentValueSubject.init(.string("")).eraseToAnyPublisher()
    public var output: CurrentValueSubject<Wrapped?, Never> = .init(.string(""))

    private var listener: AnyCancellable?

    public init() {}

    public func linkInput(_ input: CurrentValueSubject<Wrapped?, Never>, position: Int) {
        if position == 0 {
            linkParamOne(input)
        } else if position == 1 {
            linkParamTwo(input)
        }
    }

    public func remove() {
        output.send(nil)
        listener = nil
    }

    private func linkParamOne(_ link: CurrentValueSubject<Wrapped?, Never>) {
        input1 = link.eraseToAnyPublisher()
        subscribe()
    }

    private func linkParamTwo(_ link: CurrentValueSubject<Wrapped?, Never>) {
        input2 = link.eraseToAnyPublisher()
        subscribe()
    }

    private func subscribe() {
        listener = Publishers.CombineLatest(input1, input2)
            .sink { [weak output] (input1, input2) in
                output?.send(.string((input1?.string ?? "") + (input2?.string ?? "")))
            }
    }
}
