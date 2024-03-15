//  LockNode.swift
//  Created by Igor Manakov on 07.03.2024.

import SwiftUI
import Logic

class LockNode: BaseNode, ObservableObject {
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Lock
    var name: String = "Lock"
    var id: String = UUID().uuidString

    required init() {
        model = .init()
    }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(LockNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
