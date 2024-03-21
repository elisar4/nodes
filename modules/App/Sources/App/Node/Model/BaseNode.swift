//  BaseNode.swift
//  Created by Vladimir Roganov on 27.02.2024

import SwiftUI

class BaseNode: ObservableObject, Identifiable {
    var name: String { String(describing: type) }
    @Published var position: CGPoint = .randomPositionOnScreen

    var id: String = UUID().uuidString
    var type: BaseNode.Type { Self.self }

    required init() { }

    func remove() {
        fatalError()
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(Color.red)
    }
}
