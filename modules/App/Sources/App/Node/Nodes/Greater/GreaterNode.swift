//  GreaterNode.swift
//  Created by Vladimir Roganov on 07.03.2024

import SwiftUI
import Combine
import Logic

final class GreaterNode: BaseNode {

    convenience init() {
        self.init(model: Greater())
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
        AnyView(GreaterNodeView(model: self, onLinkTap: { (param) in
            controller.link(id: id, param: param)
        }))
    }
}
