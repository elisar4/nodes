//  DisplayNode.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI
import Logic

final class DisplayNode: BaseNode {
    @Published var text: String?
    var model: Display

    required init() {
        model = Display()
        super.init()
        model.action = { [weak self] in
            self?.text = $0
        }
    }

    override func remove() {
        model.remove()
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(DisplayNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
