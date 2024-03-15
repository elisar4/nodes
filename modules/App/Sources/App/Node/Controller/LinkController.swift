//  LinkController.swift
//  Created by Vladimir Roganov on 27.02.2024

import SwiftUI

protocol LinkController {
    func link(_ point: Binding<CGPoint>, id: String, param: NodeParam)
}
