//  RandomLetterNodeView.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

class RandomLetterNode: BaseNode, ObservableObject {
    @Published var position: CGPoint = .randomPositionOnScreen

    var model: RandomLetter
    var name: String = "RandomLetter"
    var id: String = UUID().uuidString

    required init() { model = .init() }

    func remove() {
        model.remove()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(RandomLetterNodeBodyView(model: self, onLinkTap: { (point, param) in
            controller.addPoint(point, id: id, param: param)
        }))
    }
}

struct RandomLetterNodeBodyView: View {
    @ObservedObject var model: RandomLetterNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            Spacer(minLength: 0)
            VStack {
                Button("Generate") {
                    model.model.run()
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
