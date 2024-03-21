//  NodeType.swift
//  Created by Aiur Arkhipov on 15.03.2024.

import Foundation
import Logic

struct NodeType {
    let name: String
    let type: BaseNode.Type
    
    static let allTypes: [NodeType] = [
        .init(name: "JoinNode", type: JoinNode.self),
        .init(name: "RandomLetterNode", type: RandomLetterNode.self),
        .init(name: "CountNode", type: CountNode.self),
        .init(name: "GreaterNode", type: GreaterNode.self),
        .init(name: "LockNode", type: LockNode.self),
        .init(name: "DisplayNode", type: DisplayNode.self),
    ]
}
