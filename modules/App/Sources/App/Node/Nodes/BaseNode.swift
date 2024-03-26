//  BaseNode.swift
//  Created by Vladimir Roganov on 27.02.2024

import SwiftUI
import Combine
import Logic

class BaseNode: ObservableObject, Identifiable, AnyNodeModel {
    var model: any NodeModel

    var name: String { String(describing: type) }
    @Published var position: CGPoint = .randomPositionOnScreen

    var linkPosition: [String: CGPoint] = [:]

    var id: String = UUID().uuidString
    var type: BaseNode.Type { Self.self }

    init(model: NodeModel) {
        self.model = model
    }

    func remove() {
        model.remove()
    }

    func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool {
        return model.linkInput(input, position: position)
    }

    func getOutput(position: Int) -> CurrentValueSubject<Wrapped, Never>? {
        return model.getOutput(position)
    }

    func linkPosition(id: String) -> CGPoint? {
        return linkPosition[id]
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(BaseNodeView(
            model: self,
            onLinkTap: { (param) in
                controller.link(id: id, param: param)
            }, display: {
                EmptyView()
            }))
    }
}

extension BaseNode {
    func builder() -> (() -> BaseNode) {
        switch self {
        case is CountNode: { CountNode() }
        case is JoinNode: { JoinNode() }
        case is DisplayNode: { DisplayNode() }
        case is GreaterNode: { GreaterNode() }
        case is LockNode: { LockNode() }
        case is RandomLetterNode: { RandomLetterNode() }
        default: { fatalError() }
        }
    }
}

protocol AnyNodeModel {
    var model: NodeModel { get }
}
