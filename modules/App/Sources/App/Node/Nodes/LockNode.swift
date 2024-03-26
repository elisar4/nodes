//  LockNode.swift
//  Created by Igor Manakov on 07.03.2024.

import Logic

final class LockNode: BaseNode {
    convenience init() {
        self.init(model: Lock())
    }
}
