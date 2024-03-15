//  CountNode.swift
//  Created by Igor Manakov on 04.03.2024.

import SwiftUI
import Logic

class CountNode: BaseNode, ObservableObject {
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Count
    var name: String = "Count"
    var id: String = UUID().uuidString

    required init() {
        model = .init()
    }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(CountNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
