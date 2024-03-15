//  WorkspaceOffset.swift
//  Created by Vladimir Roganov on 05.03.2024

import SwiftUI

struct WorkspaceOffset<Content: View>: View {
    @Binding var offset: CGPoint
    @State var initialOffset: CGPoint = .zero
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            content()
        }
        .gesture(drag)
    }

    private var drag: some Gesture {
        DragGesture()
            .onChanged { model in
                offset = .init(x: initialOffset.x + model.translation.width,
                               y: initialOffset.y + model.translation.height)
            }
            .onEnded { model in
                initialOffset = .init(x: initialOffset.x + model.translation.width,
                                      y: initialOffset.y + model.translation.height)
                offset = initialOffset
            }
    }
}
