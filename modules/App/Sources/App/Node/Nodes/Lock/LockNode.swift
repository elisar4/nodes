//  LockNode.swift
//  Created by Igor Manakov on 07.03.2024.

import SwiftUI
import Logic
import Combine

final class LockNode: BaseNode {

    convenience init() {
        self.init(model: Lock())
    }

    override func remove() {
        model.remove()
    }

    override func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool {
        return model.linkInput(input, position: position)
    }

    override func getOutput(position: Int) -> CurrentValueSubject<Wrapped, Never>? {
        return model.getOutput(position)
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(LockNodeView(model: self, onLinkTap: { (param) in
            controller.link(id: id, param: param)
        }))
    }
}
