//  WorkspaceController.swift
//  Created by Aiur Arkhipov on 19.02.2024.

import SwiftUI
import Logic
import Combine

final class WorkspaceController: LinkController, ObservableObject {
    @Published var links: [Link] = []
    @Published var nodes: [BaseNode] = []
    @Published var selection: (BaseNode)?
    @Published var topNodeID: String?
    @Published var workspaceDragOffset: CGPoint = .zero

    var currentWorkspaceState: WorkspaceState {
        return .init(
            links: links,
            nodes: nodes.map(BaseNodeState.init(node:)),
            offset: workspaceDragOffset
        )
    }

    private var tappedPoint: Binding<CGPoint>?
    private var tappedID: String?

    private var tappedParam: NodeParam?

    func loadState(_ state: WorkspaceState) {
        links = []
        nodes = []
        clear()
        nodes = state.nodes.map(\.restored)
        workspaceDragOffset = state.offset
        // restore links
//        for link in state.links {
//            let fromNode = nodes.first(where: {$0.id == link.fromId})
//            let newLink = Link.init(from: formNode.point,
//                                    to: .constant(.zero),
//                                    fromId: link.fromId,
//                                    toId: link.toId,
//                                    toPosition: link.toPosition)
//            links.append(newLink)
//        }
    }

    func link(_ point: Binding<CGPoint>, id: String, param: NodeParam) {
        if let tappedParam, let tappedPoint, let tappedID {
            if tappedID == id {
                return
            }
            switch (tappedParam, param) {
            case (.input(let input, let position), .output(let output)):
                link(input: input,
                     position: position,
                     output: output,
                     tappedPoint: tappedPoint,
                     point: point,
                     inputNodeId: tappedID,
                     outputNodeId: id)
            case (.output(let output), .input(let input, let position)):
                link(input: input,
                     position: position,
                     output: output,
                     tappedPoint: tappedPoint,
                     point: point,
                     inputNodeId: id,
                     outputNodeId: tappedID)
            default:
                clear()
            }
        } else {
            tappedParam = param
            tappedPoint = point
            tappedID = id
        }
    }

    private func link(input: NodeInput, position: Int, output: CurrentValueSubject<Wrapped, Never>, tappedPoint: Binding<CGPoint>, point: Binding<CGPoint>, inputNodeId: String, outputNodeId: String) {
        let success = input.linkInput(output, position: position)
        guard success else {
            // todo: feedback to user
            print("Error: can't connect provided output with provided input")
            return
        }
        links = links.filter({ "\($0.toId)\($0.toPosition)" != "\(inputNodeId)\(position)" })
        links.append(Link(from: tappedPoint,
                           to: point,
                           fromId: outputNodeId,
                           toId: inputNodeId,
                           toPosition: position))
        clear()
    }

    func clear() {
        tappedParam = nil
        tappedPoint = nil
        tappedID = nil
    }
}

// MARK: - Selection

extension WorkspaceController {
    func didTapNode(_ node: BaseNode) {
        if selection?.id == node.id {
            selection = nil
        } else {
            selection = node
        }
    }

    func didTapBackground() {
        selection = nil
    }
}

// MARK: - Removing

extension WorkspaceController {
    func removeSelectedNode() {
        guard let selection,
              let idx = nodes.firstIndex(where: { $0.id == selection.id }) else {
            return
        }
        let uid = selection.id
        selection.remove()
        self.selection = nil
        nodes.remove(at: idx)
        links = links.filter({ !($0.fromId == uid || $0.toId == uid) })
    }
}
