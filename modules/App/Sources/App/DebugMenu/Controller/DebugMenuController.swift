//  DebugMenuController.swift
//  Created by Aiur Arkhipov on 15.03.2024.

import Combine

class DebugMenuController: ObservableObject {
    @Published var debugState: WorkspaceState?

    private let workspace: WorkspaceController

    init(workspace: WorkspaceController) {
        self.workspace = workspace
    }
    
    func reset() {
        workspace.links = []
        workspace.nodes = []
        workspace.clear()
    }
    
    func addRandomNode() {
        let randomNode = NodeType.allTypes.randomElement()!.build()
        addNode(randomNode)
    }
    
    func addNode(_ node: BaseNode) {
        workspace.nodes.append(node)
    }

    func saveDebugState() {
        debugState = workspace.currentWorkspaceState
    }

    func loadDebugState() {
        guard let debugState else {
            print("Debug state noo")
            return
        }
        workspace.loadState(debugState)
    }
}
