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
    var offset: CGPoint
}

protocol BaseNodeState {
    var id: String { get }
    var name: String { get }
    var position: CGPoint { get }
}

extension Link: LinkState {}
