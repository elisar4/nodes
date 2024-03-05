//  WorkspaceBackground.swift
//  Created by Vladimir Roganov on 05.03.2024

import SwiftUI

struct WorkspaceBackground: View {
    var windowSize: CGSize
    var workspaceOffset: CGPoint

    private let patternSize: CGFloat = 30

    var body: some View {
        Image("bgPattern")
            .resizable(resizingMode: .tile)
            .offset(.init(
                width: workspaceOffset.x.truncatingRemainder(dividingBy: patternSize) - patternSize * 4,
                height: workspaceOffset.y.truncatingRemainder(dividingBy: patternSize) - patternSize * 4))
            .frame(width: windowSize.width + patternSize * 8, height: windowSize.height + patternSize * 8)
            .ignoresSafeArea()
    }
}
