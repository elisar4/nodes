//  BaseNode.swift
//  Created by Vladimir Roganov on 27.02.2024

import SwiftUI
import Combine
import Logic

class BaseNode: ObservableObject, Identifiable {
    var name: String { String(describing: type) }
    @Published var position: CGPoint = .randomPositionOnScreen

    var linkPosition: [String: CGPoint] = [:]

    var id: String = UUID().uuidString
    var type: BaseNode.Type { Self.self }

    required init() { }

    func remove() {
        fatalError()
    }

    func linkInput(_ input: CurrentValueSubject<Wrapped, Never>, position: Int) -> Bool {
        fatalError()
    }

    func getOutput(position: Int) -> CurrentValueSubject<Wrapped, Never>? {
        fatalError()
    }

    func linkPosition(id: String) -> CGPoint? {
        return linkPosition[id]
    }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(Color.red)
    }
}
