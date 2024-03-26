//  DisplayNode.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI
import Combine
import Logic

final class DisplayNode: BaseNode {
    @Published var text: String?

    convenience init() {
        let model = Display()
        self.init(model: model)
        model.action = { [weak self] in
            self?.text = $0
        }
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(DisplayNodeView(model: self, onLinkTap: { (param) in
            controller.link(id: id, param: param)
        }))
    }
}
