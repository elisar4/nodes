//  BaseNode.swift
//  Created by Vladimir Roganov on 27.02.2024

import SwiftUI

protocol BaseNode: AnyObject, Identifiable {
    var id: String { get }
    var name: String { get }
    var position: CGPoint { get set }
    init()
    func remove()
    func build(controller: LinkController, id: String) -> AnyView
}
