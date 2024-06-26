//  Lock.swift
//  Created by Igor Manakov on 07.03.2024.

import Combine

public class Lock: NodeModel {
    public func run() {}
    
    public var input1: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.string(nil)).eraseToAnyPublisher()
    public var input2: AnyPublisher<Wrapped, Never> = CurrentValueSubject.init(.bool(nil)).eraseToAnyPublisher()
    public var output: CurrentValueSubject<Wrapped, Never> = .init(.string(nil))

    private let inputTypes: [Int: [String]] = [
        0: ["s"],
        1: ["b"],
    ]

    private let outputTypes: [Int: [String]] = [
        0: ["s"],
    ]

    private var listener: AnyCancellable?

    public init() {}

    @discardableResult
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
            return output
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
        output.send(.string(nil))
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
        listener = Publishers.CombineLatest(input1, input2)
            .sink { [weak output] (input1, input2) in
                if input2.bool == true {
                    output?.send(input1)
                } else {
                    output?.send(.string(nil))
                }
            }
    }
}

