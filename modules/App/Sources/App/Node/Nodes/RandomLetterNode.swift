//  RandomLetterNode.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic
import Combine

final class RandomLetterNode: BaseNode {

    convenience init() {
        self.init(model: RandomLetter())
    }

    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(BaseNodeView(
            model: self,
            onLinkTap: { (param) in
                controller.link(id: id, param: param)
            }, display: {
                Button("Generate") {
                    self.model.run()
                }
            }))
    }
}
