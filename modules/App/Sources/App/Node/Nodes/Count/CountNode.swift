//  CountNode.swift
//  Created by Igor Manakov on 04.03.2024.

import SwiftUI
import Combine
import Logic

final class CountNode: BaseNode {

    convenience init() {
        self.init(model: Count())
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
        AnyView(CountNodeView(model: self, onLinkTap: { (param) in
            controller.link(id: id, param: param)
        }))
    }
}
