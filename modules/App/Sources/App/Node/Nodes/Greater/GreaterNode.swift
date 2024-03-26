//  GreaterNode.swift
//  Created by Vladimir Roganov on 07.03.2024

import SwiftUI
import Combine
import Logic

final class GreaterNode: BaseNode {

    convenience init() {
        self.init(model: Greater())
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(BaseNodeView(
            model: self, onLinkTap: { (param) in
                controller.link(id: id, param: param)
            }, display: {
                EmptyView()
            }))
    }
}
