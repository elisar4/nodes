//  RandomLetterNodeView.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

class RandomLetterNode: BaseNode, ObservableObject {
    var model: RandomLetter
    var name: String = "RandomLetter"
    var id: String = UUID().uuidString

    init(model: RandomLetter = .init()) {
        self.model = model
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
            VStack {
                Button("Active random generation") {
                    model.model.run()
                }
            }
            Spacer(minLength: 0)
            LinkPointView(onTap: {
                onLinkTap($0, .output(model.model.output))
            })
        }
        .padding(.vertical, 8)
    }
}
