//  DisplayNode.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI
import Logic

class DisplayNode: BaseNode, ObservableObject {
    @Published var text: String?
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Display
    var name: String = "Display"
    var id: String = UUID().uuidString

    required init() {
        model = .init()
        model.action = { [weak self] in
            self?.text = $0
        }
    }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(DisplayNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
