//  BaseNode.swift
//  Created by Vladimir Roganov on 27.02.2024

import SwiftUI

protocol BaseNode: Identifiable {
    var id: String { get }
    var name: String { get }
    init()
    func remove()
    func build(controller: LinkController, id: String) -> AnyView
}
