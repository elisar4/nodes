//  BaseNode+Builder.swift
//  Created by Aiur Arkhipov on 26.03.2024.

import Foundation

extension BaseNode {
    static func builder(for type: BaseNode.Type) -> (() -> BaseNode) {
        switch type {
        case is CountNode.Type: { CountNode() }
        case is JoinNode.Type: { JoinNode() }
        case is DisplayNode.Type: { DisplayNode() }
        case is GreaterNode.Type: { GreaterNode() }
        case is LockNode.Type: { LockNode() }
        case is RandomLetterNode.Type: { RandomLetterNode() }
        default: { fatalError() }
        }
    }
}
