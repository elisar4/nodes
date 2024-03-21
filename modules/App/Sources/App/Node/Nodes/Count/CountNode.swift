//  CountNode.swift
//  Created by Igor Manakov on 04.03.2024.

import SwiftUI
import Logic

final class CountNode: BaseNode {
    var model: Count

    required init() {
        model = Count()
        super.init()
    }

    override func remove() {
        model.remove()
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(CountNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
