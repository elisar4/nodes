//  CountNode.swift
//  Created by Igor Manakov on 04.03.2024.

import SwiftUI
import Combine
import Logic

final class CountNode: BaseNode {

    convenience init() {
        self.init(model: Count())
    }
    
    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(BaseNodeView(model: self, onLinkTap: { (param) in
            controller.link(id: id, param: param)
        }))
    }
}
