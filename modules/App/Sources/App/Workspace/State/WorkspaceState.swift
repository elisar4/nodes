//  WorkspaceState.swift
//  Created by Vladimir Roganov on 20.03.2024

import Foundation

struct WorkspaceState {
    var links: [LinkState] = []
    var nodes: [BaseNodeState] = []
    var offset: CGPoint = .zero
}
