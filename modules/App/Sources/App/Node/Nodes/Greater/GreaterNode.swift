//  GreaterNode.swift
//  Created by Vladimir Roganov on 07.03.2024

import SwiftUI
import Logic

final class GreaterNode: BaseNode {
    var model: Greater

    required init() {
        model = Greater()
        super.init()
    }

    override func remove() {
        model.remove()
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(GreaterNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
