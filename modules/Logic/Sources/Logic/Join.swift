//  Join.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public class Join: NodeInput {
    public var input1: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.string("")).eraseToAnyPublisher()
    public var input2: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.string("")).eraseToAnyPublisher()
    public var output: CurrentValueSubject<Wrapped, Never> = .init(.string(""))

    let allowedTypes: [Int: [String]] = [
        0: ["s"],
        1: ["s"],
    ]

    private var listener: AnyCancellable?

    public init() {}

    public func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool {
        guard position == 0 || position == 1 else {
            return false
        }
        guard allowedTypes[position]?.contains(input.value.type) == true else {
            return false
        }
        if position == 0 {
            linkParamOne(input)
        } else if position == 1 {
            linkParamTwo(input)
        }
        return true
    }

    public func remove() {
        output.send(.string(nil))
        listener = nil
    }

    private func linkParamOne(_ link: CurrentValueSubject<Wrapped, Never>) {
        input1 = link.eraseToAnyPublisher()
        subscribe()
    }

    private func linkParamTwo(_ link: CurrentValueSubject<Wrapped, Never>) {
        input2 = link.eraseToAnyPublisher()
        subscribe()
    }

    private func subscribe() {
        listener = Publishers.CombineLatest(input1, input2)
            .sink { [weak output] (input1, input2) in
                output?.send(.string((input1.string ?? "") + (input2.string ?? "")))
            }
    }
}
