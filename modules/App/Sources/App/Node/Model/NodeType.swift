//  NodeType.swift
//  Created by Aiur Arkhipov on 15.03.2024.

import Foundation
import Logic

struct NodeType {
    let name: String
    let build: () -> BaseNode

    static let allTypes: [NodeType] = [
        .init(name: "DisplayNode", build: { DisplayNode() }),
        .init(name: "RandomLetterNode", build: { RandomLetterNode() }),
        .init(name: "JoinNode", build: { JoinNode() }),
        .init(name: "CountNode", build: { CountNode() }),
        .init(name: "GreaterNode", build: { GreaterNode() }),
        .init(name: "LockNode", build: { LockNode() }),
    ]
}
