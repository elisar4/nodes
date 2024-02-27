//  Join.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public class Join: NodeInput {
    public var input1: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
    public var input2: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
    public var output: PassthroughSubject<String?, Never> = .init()

    private var listener: AnyCancellable?

    public init() {}

    public func linkInput(_ input: PassthroughSubject<String?, Never>, position: Int) {
        if position == 0 {
            linkParamOne(input)
        } else if position == 1 {
            linkParamTwo(input)
        } else {

        }
    }

    func linkParamOne(_ link: PassthroughSubject<String?, Never>) {
        input1 = link.eraseToAnyPublisher()
        subscribe()
    }

    func linkParamTwo(_ link: PassthroughSubject<String?, Never>) {
        input2 = link.eraseToAnyPublisher()
        subscribe()
    }

    private func subscribe() {
        listener = Publishers.CombineLatest(input1, input2)
            .sink { [weak output] (input1, input2) in
                output?.send((input1 ?? "") + (input2 ?? ""))
            }
    }
}
