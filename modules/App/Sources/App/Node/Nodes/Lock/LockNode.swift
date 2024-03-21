//  LockNode.swift
//  Created by Igor Manakov on 07.03.2024.

import SwiftUI
import Logic

final class LockNode: BaseNode {
    var model: Lock

    required init() {
        model = Lock()
        super.init()
    }

    override func remove() {
        model.remove()
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(LockNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
