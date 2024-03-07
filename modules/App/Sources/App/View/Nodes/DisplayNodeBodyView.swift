//  DisplayNodeBodyView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI
import Logic

class DisplayNode: BaseNode, ObservableObject {
    @Published var text: String?
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Display
    var name: String = "Display"
    var id: String = UUID().uuidString

    required init() {
        model = .init()
        model.action = { [weak self] in
            self?.text = $0
        }
    }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(DisplayNodeBodyView(model: self, onLinkTap: { (point, param) in
            controller.addPoint(point, id: id, param: param)
        }))
    }
}

struct DisplayNodeBodyView: View {
    @ObservedObject var model: DisplayNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            LinkPointView {
                LinkColor(allowedTypes: model.model.allowedInputTypes(0)).view
            } onTap: {
                onLinkTap($0, .input(model.model, 0))
            }
            Spacer(minLength: 0)
            Text(model.text ?? "nil")
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
