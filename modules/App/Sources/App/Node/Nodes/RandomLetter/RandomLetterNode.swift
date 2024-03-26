//  RandomLetterNode.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic
import Combine

final class RandomLetterNode: BaseNode {
    var model: RandomLetter

    required init() {
        model = RandomLetter()
        super.init()
    }

    override func remove() {
        model.remove()
    }

    override func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool {
        return false
    }

    override func getOutput(position: Int) -> CurrentValueSubject<Wrapped, Never>? {
        return model.getOutput(position)
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(RandomLetterNodeView(model: self, onLinkTap: { (param) in
            controller.link(id: id, param: param)
        }))
    }
}
