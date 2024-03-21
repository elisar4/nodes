//  Greater.swift
//  Created by Vladimir Roganov on 07.03.2024

import Foundation
import Combine

public class Greater: NodeInput, NodeOutput {
    public var input1: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.int(nil)).eraseToAnyPublisher()
    public var input2: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.int(nil)).eraseToAnyPublisher()
    public var output1: CurrentValueSubject<Wrapped, Never> = .init(.bool(nil))
    public var output2: CurrentValueSubject<Wrapped, Never> = .init(.bool(nil))

    private let inputTypes: [Int: [String]] = [
        0: ["i"],
        1: ["i"],
    ]

    private let outputTypes: [Int: [String]] = [
        0: ["b"],
        1: ["b"],
    ]

    private var listener: AnyCancellable?

    public init() {}

    public func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool {
        guard allowedInputTypes(position).contains(input.value.type) else {
            return false
        }
        if position == 0 {
            linkParamOne(input)
        } else if position == 1 {
            linkParamTwo(input)
        }
        return true
    }

    public func getOutput(_ position: Int) -> CurrentValueSubject<Wrapped, Never>? {
        if position == 0 {
            return output1
        }
        if position == 1 {
            return output2
        }
        return nil
    }

    public var inputsCount: Int {
        return inputTypes.keys.count
    }

    public var outputsCount: Int {
        return outputTypes.keys.count
    }

    public func remove() {
        output1.send(.bool(nil))
        output2.send(.bool(nil))
        listener = nil
    }

    public func allowedInputTypes(_ position: Int) -> [String] {
        inputTypes[position] ?? []
    }

    public func allowedOutputTypes(_ position: Int) -> [String] {
        outputTypes[position] ?? []
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
        listener = Publishers.CombineLatest(input1, input2).sink { [weak self] wrapped1, wrapped2 in
            guard let value1 = wrapped1.int, let value2 = wrapped2.int else {
                self?.output1.send(.bool(nil))
                self?.output2.send(.bool(nil))
                return
            }
            let result = value1 > value2
            self?.output1.send(.bool(result))
            self?.output2.send(.bool(!result))
        }
    }
}
