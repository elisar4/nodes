//  NodeLinkController.swift
//  Created by Aiur Arkhipov on 19.02.2024.

import SwiftUI
import Logic
import Combine

final class NodeLinkController: LinkController, ObservableObject {
    @Published var links: [Link] = []
    @Published var nodes: [any BaseNode] = []
    @Published var selection: (any BaseNode)?
    @Published var topNodeID: String?
    @Published var workspaceDragOffset: CGPoint = .zero

    private var tappedPoint: Binding<CGPoint>?
    private var tappedID: String?

    private var tappedParam: NodeParam?

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

extension NodeLinkController {
    func didTapNode(_ node: any BaseNode) {
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

extension NodeLinkController {
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
