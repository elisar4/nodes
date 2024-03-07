//  LockNode.swift
//  Created by Igor Manakov on 07.03.2024.

import SwiftUI
import Logic

class LockNode: BaseNode, ObservableObject {
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Lock
    var name: String = "Lock"
    var id: String = UUID().uuidString

    required init() {
        model = .init()
    }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(LockNodeView(model: self, onLinkTap: { (point, param) in
            controller.addPoint(point, id: id, param: param)
        }))
    }
}

struct LockNodeView: View {
    @ObservedObject var model: LockNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            VStack {
                LinkPointView {
                    LinkColor(allowedTypes: model.model.allowedInputTypes(0)).view
                } onTap: {
                    onLinkTap($0, .input(model.model, 0))
                }

                LinkPointView {
                    LinkColor(allowedTypes: model.model.allowedInputTypes(1)).view
                } onTap: {
                    onLinkTap($0, .input(model.model, 1))
                }
            }

            Spacer(minLength: 0)
            LinkPointView {
                LinkColor(allowedTypes: model.model.allowedOutputTypes(0)).view
            } onTap: {
                onLinkTap($0, .output(model.model.output))
            }
        }
        .padding(.vertical, 8)
    }
}
