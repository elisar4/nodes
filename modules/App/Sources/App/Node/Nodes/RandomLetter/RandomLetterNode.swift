//  RandomLetterNode.swift
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
        AnyView(RandomLetterNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
