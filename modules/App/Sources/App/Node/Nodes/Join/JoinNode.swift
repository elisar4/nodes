//  JoinNode.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

final class JoinNode: BaseNode, ObservableObject {
    var type: any BaseNode.Type { JoinNode.self }
    
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Join
    var name: String = "Join"
    var id: String = UUID().uuidString

    required init() { model = .init() }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(JoinNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
