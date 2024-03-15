//  NodeParam.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import Combine
import Logic

enum NodeParam {
    case input(NodeInput, Int)
    case output(CurrentValueSubject<Wrapped, Never>)
}
