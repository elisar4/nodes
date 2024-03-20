//  DebugMenuController.swift
//  Created by Aiur Arkhipov on 15.03.2024.

import Combine

class DebugMenuController: ObservableObject {
    let nodeLinkController: NodeLinkController
    
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
        nodeLinkController.saveDebugState()
    }
    
    func loadDebugState() {
        nodeLinkController.loadDebugState()
    }
}
