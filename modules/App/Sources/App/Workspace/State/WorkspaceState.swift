//  WorkspaceState.swift
//  Created by Vladimir Roganov on 20.03.2024

import Foundation

protocol LinkState {
    var id: String { get }
    var fromId: String { get }
    var toId: String { get }
    var toPosition: Int { get }
}

struct WorkspaceState {
    var links: [LinkState] = []
    var nodes: [BaseNodeState] = []
    var offset: CGPoint = .zero
}

protocol BaseNodeState {
    var id: String { get }
    var name: String { get }
    var position: CGPoint { get }
    var type: any BaseNode.Type { get }
}

struct BaseNodeStateStruct: BaseNodeState {
    let id: String
    let name: String
    let position: CGPoint
    let type: any BaseNode.Type
    
    init(node: any BaseNode) {
        self.id = node.id
        self.name = node.name
        self.position = node.position
        self.type = node.type
    }
}

extension Link: LinkState {}
