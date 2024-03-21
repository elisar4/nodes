//  DebugMenuController.swift
//  Created by Aiur Arkhipov on 15.03.2024.

import Combine

class DebugMenuController: ObservableObject {
    @Published var debugState: WorkspaceState?

    private let nodeLinkController: NodeLinkController

    init(nodeLinkController: NodeLinkController) {
        self.nodeLinkController = nodeLinkController
    }
    
    func reset() {
        nodeLinkController.links = []
        nodeLinkController.nodes = []
        nodeLinkController.clear()
    }
    
    func addRandomNode() {
        let randomNode = NodeType.allTypes.randomElement()!.type.init()
        addNode(randomNode)
    }
    
    func addNode(_ node: any BaseNode) {
        nodeLinkController.nodes.append(node)
    }

    func saveDebugState() {
        debugState = nodeLinkController.currentWorkspaceState
    }

    func loadDebugState() {
        guard let debugState else {
            print("Debug state noo")
            return
        }
        nodeLinkController.loadState(debugState)
    }
}
