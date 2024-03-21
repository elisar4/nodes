//  WorkspaceController.swift
//  Created by Aiur Arkhipov on 19.02.2024.

import SwiftUI
import Logic
import Combine

final class WorkspaceController: LinkController, ObservableObject {
    @Published var links: [LinkPathModel] = []
    @Published var nodes: [BaseNode] = []
    @Published var selection: (BaseNode)?
    @Published var topNodeID: String?
    @Published var workspaceDragOffset: CGPoint = .zero

    var currentWorkspaceState: WorkspaceState {
        return .init(
            links: linkModels,
            nodes: nodes.map(BaseNodeState.init(node:)),
            offset: workspaceDragOffset
        )
    }

    private var linkModels: [Link] = []

    private var tappedID: String?
    private var tappedParam: NodeParam?

    private var nodesListener: AnyCancellable?
    private var bag: [AnyCancellable] = []

    init() {
        subscribe()
    }

    private func subscribe() {
        nodesListener = $nodes.sink { [weak self] models in
            self?.bag = models.map {
                $0.$position.sink(receiveValue: { _ in
                    self?.redrawLinks()
                })
            }
        }
    }

    private func redrawLinks() {
        links = getLinks(linkModels)
    }

    func loadState(_ state: WorkspaceState) {
        links = []
        linkModels = []
        nodes = []
        clear()
        nodes = state.nodes.map(\.restored)
        linkModels = state.links.map(\.restored)
        workspaceDragOffset = state.offset

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.redrawLinks()
        })
    }

    func getLinks(_ items: [Link]) -> [LinkPathModel] {
        var result: [LinkPathModel] = []
        for item in items {
            guard let fromNode = nodes.first(where: { $0.id == item.fromId }),
                  let toNode = nodes.first(where: { $0.id == item.toId }) else {
                continue
            }
            guard let output = fromNode.getOutput(position: item.fromPosition) else {
                continue
            }
            let success = toNode.linkInput(output, position: item.toPosition)
            guard success,
                  let pointFrom = fromNode.linkPosition(id: "output\(item.fromPosition)"),
                  let pointTo = toNode.linkPosition(id: "input\(item.toPosition)") else {
                continue
            }
            result.append(LinkPathModel(from: pointFrom, to: pointTo))
        }
        return result
    }

    func link(id: String, param: NodeParam) {
        if let tappedParam, let tappedID {
            if tappedID == id {
                return
            }
            switch (tappedParam, param) {
            case (.input(let input, let position), .output(let output, let fromPosition)):
                link(input: input,
                     position: position,
                     output: output.getOutput(fromPosition)!,
                     fromPosition: fromPosition,
                     inputNodeId: tappedID,
                     outputNodeId: id)
            case (.output(let output, let fromPosition), .input(let input, let position)):
                link(input: input,
                     position: position,
                     output: output.getOutput(fromPosition)!,
                     fromPosition: fromPosition,
                     inputNodeId: id,
                     outputNodeId: tappedID)
            default:
                clear()
            }
        } else {
            tappedParam = param
            tappedID = id
        }
    }

    private func link(input: NodeInput, position: Int, output: CurrentValueSubject<Wrapped, Never>, fromPosition: Int, inputNodeId: String, outputNodeId: String) {
        let success = input.linkInput(output, position: position)
        guard success else {
            // todo: feedback to user
            print("Error: can't connect provided output with provided input")
            return
        }
        linkModels = linkModels.filter({ "\($0.toId)\($0.toPosition)" != "\(inputNodeId)\(position)" })
        linkModels.append(Link(
            fromId: outputNodeId,
            fromPosition: fromPosition,
            toId: inputNodeId,
            toPosition: position
        ))
        clear()
        redrawLinks()
    }

    func clear() {
        tappedParam = nil
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
        linkModels = linkModels.filter({ !($0.fromId == uid || $0.toId == uid) })
    }
}
