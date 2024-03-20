//  Link.swift
//  Created by Aiur Arkhipov on 19.02.2024.

import SwiftUI

struct Link: Identifiable {
    let id: String = UUID().uuidString

    let from: Binding<CGPoint>
    let to: Binding<CGPoint>
    let fromId: String
    let toId: String
    let toPosition: Int
}