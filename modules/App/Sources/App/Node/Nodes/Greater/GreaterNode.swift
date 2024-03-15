//  GreaterNode.swift
//  Created by Vladimir Roganov on 07.03.2024

import SwiftUI
import Logic

final class GreaterNode: BaseNode, ObservableObject {
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Greater
    var name: String = "Greater"
    var id: String = UUID().uuidString

    required init() { model = .init() }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(GreaterNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
