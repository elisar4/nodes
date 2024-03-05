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
            .position(.init(
                x: windowSize.width * 1.25 - workspaceOffset.x + workspaceOffset.x.truncatingRemainder(dividingBy: patternSize),
                y: windowSize.height * 1.25 - workspaceOffset.y + workspaceOffset.y.truncatingRemainder(dividingBy: patternSize)))
            .frame(width: windowSize.width * 1.5, height: windowSize.height * 1.5)
    }
}
