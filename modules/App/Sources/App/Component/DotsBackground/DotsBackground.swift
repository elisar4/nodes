//  DotsBackground.swift
//  Created by Vladimir Roganov on 10.03.2024

import SwiftUI

struct DotsBackground: View {
    var offset: CGPoint = .zero
    var color: Color = .secondary
    var dotRadius: CGFloat = 1.5
    var dotSpacing: CGFloat = 30.0

    var body: some View {
        Color.blue
            .colorEffect(ShaderLibrary.bundle(.module).dotsPattern(
                .float(dotSpacing),
                .float(dotRadius),
                .color(color),
                .float2(offset)
            ))
    }
}

#Preview {
    DotsBackground(dotRadius: 4)
}
