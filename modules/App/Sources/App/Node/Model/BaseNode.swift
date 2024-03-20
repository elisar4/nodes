//  BaseNode.swift
//  Created by Vladimir Roganov on 27.02.2024

import SwiftUI

protocol BaseNode: AnyObject, Identifiable, BaseNodeState {
    var id: String { get set }
    var name: String { get set }
    var position: CGPoint { get set }
    init()
    func remove()
    func build(controller: LinkController, id: String) -> AnyView
    var type: any BaseNode.Type { get }
}
