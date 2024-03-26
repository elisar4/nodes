//  BaseNodeState.swift
//  Created by Vladimir Roganov on 21.03.2024

import Foundation

struct BaseNodeState {
    let id: String
    let name: String
    let position: CGPoint
    let build: () -> BaseNode

    init(node: BaseNode) {
        self.id = node.id
        self.name = node.name
        self.position = node.position
        self.build = node.builder()
    }

    var restored: BaseNode {
        let model = build()
        model.position = position
        model.id = id
        return model
    }
}
