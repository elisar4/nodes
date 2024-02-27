//  NodeInput.swift
//  Created by Igor Manakov on 27.02.2024.

import Combine

public protocol NodeInput {
    func linkInput(_ input: PassthroughSubject<String?, Never>, position: Int)
}
