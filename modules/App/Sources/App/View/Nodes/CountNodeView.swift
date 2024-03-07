//  CountNodeView.swift
//  Created by Igor Manakov on 04.03.2024.

import SwiftUI
import Logic

class CountNode: BaseNode, ObservableObject {
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: Count
    var name: String = "Count"
    var id: String = UUID().uuidString

    required init() {
        model = .init()
    }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(CountNodeBodyView(model: self, onLinkTap: { (point, param) in
            controller.addPoint(point, id: id, param: param)
        }))
    }
}

struct CountNodeBodyView: View {
    @ObservedObject var model: CountNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            LinkPointView {
                LinkColor(allowedTypes: model.model.allowedInputTypes(0)).view
            } onTap: {
                onLinkTap($0, .input(model.model, 0))
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
