//  LockNode.swift
//  Created by Igor Manakov on 07.03.2024.

import SwiftUI
import Logic
import Combine

final class LockNode: BaseNode {

    convenience init() {
        self.init(model: Lock())
    }
    
    override func build(controller: LinkController, id: String) -> AnyView {
        AnyView(BaseNodeView(
            model: self,
            onLinkTap: { (param) in
                controller.link(id: id, param: param)
            }, display: {
                EmptyView()
            }))
    }
}
