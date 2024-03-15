//  WorkspaceBackground.swift
//  Created by Vladimir Roganov on 05.03.2024

import SwiftUI

struct WorkspaceBackground: View {
    var offset: CGPoint
    var body: some View {
        DotsBackground(offset: .init(x: -offset.x, y: -offset.y))
            .ignoresSafeArea()
    }
}
