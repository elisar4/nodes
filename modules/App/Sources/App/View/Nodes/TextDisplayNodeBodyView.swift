//  TextDisplayNodeBodyView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI
import Logic

class DisplayNode: BaseNode, ObservableObject {
    @Published var text: String?

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
        AnyView(TextDisplayNodeBodyView(model: self, onLinkTap: { (point, param) in
            controller.addPoint(point, id: id, param: param)
        }))
    }
}

struct TextDisplayNodeBodyView: View {
    @ObservedObject var model: DisplayNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            LinkPointView(onTap: {
                onLinkTap($0, .input(model.model, 0))
            })
            Spacer(minLength: 0)
            Text(model.text ?? "nil")
            Spacer(minLength: 0)
            LinkPointView(onTap: {
                onLinkTap($0, .output(model.model.output))
            })
        }
        .padding(.vertical, 8)
    }
}
