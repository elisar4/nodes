//  BaseNodeState.swift
//  Created by Vladimir Roganov on 21.03.2024

import Foundation

struct BaseNodeState {
    let id: String
    let name: String
    let position: CGPoint
    let type: BaseNode.Type
    var build: () -> BaseNode {
        BaseNode.builder(for: type)
    }

    init(node: BaseNode) {
        self.id = node.id
        self.name = node.name
        self.position = node.position
        self.type = node.type
    }

    var restored: BaseNode {
        let model = build()
        model.position = position
        model.id = id
        return model
    }
}
