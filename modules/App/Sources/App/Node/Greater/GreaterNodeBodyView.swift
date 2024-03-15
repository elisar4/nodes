//  GreaterNodeBodyView.swift
//  Created by Vladimir Roganov on 07.03.2024

import SwiftUI
import Logic

final class GreaterNode: BaseNode, ObservableObject {
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Greater
    var name: String = "Greater"
    var id: String = UUID().uuidString

    required init() { model = .init() }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(GreaterNodeBodyView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}

struct GreaterNodeBodyView: View {
    @ObservedObject var model: GreaterNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            VStack {
                LinkPointView {
                    LinkColor(allowedTypes: model.model.allowedInputTypes(0)).view
                } onTap: { onLinkTap($0, .input(model.model, 0)) }
                LinkPointView {
                    LinkColor(allowedTypes: model.model.allowedInputTypes(1)).view
                } onTap: { onLinkTap($0, .input(model.model, 1)) }
            }
            Spacer(minLength: 0)
            VStack {
                LinkPointView {
                    LinkColor(allowedTypes: model.model.allowedOutputTypes(0)).view
                } onTap: { onLinkTap($0, .output(model.model.output1)) }
                LinkPointView {
                    LinkColor(allowedTypes: model.model.allowedOutputTypes(1)).view
                } onTap: { onLinkTap($0, .output(model.model.output2)) }
            }
        }
        .padding(.vertical, 8)
    }
}
