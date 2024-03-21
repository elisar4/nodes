//  RandomLetterNode.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

final class RandomLetterNode: BaseNode {
    var model: RandomLetter

    required init() {
        model = RandomLetter()
        super.init()
    }

    override func remove() {
        model.remove()
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(RandomLetterNodeView(model: self, onLinkTap: { (point, param) in
            controller.link(point, id: id, param: param)
        }))
    }
}
