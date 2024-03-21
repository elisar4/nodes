//  JoinNode.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

final class JoinNode: BaseNode {
    var model: Join

    required init() {
        model = Join()
        super.init()
    }

    override func remove() {
        model.remove()
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(JoinNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
