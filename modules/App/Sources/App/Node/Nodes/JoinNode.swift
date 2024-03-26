//  JoinNode.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import Logic

final class JoinNode: BaseNode {
    convenience init() {
        self.init(model: Join())
    }
}
