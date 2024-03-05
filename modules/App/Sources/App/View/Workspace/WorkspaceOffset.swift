//  WorkspaceOffset.swift
//  Created by Vladimir Roganov on 05.03.2024

import SwiftUI

struct WorkspaceOffset<Content: View>: View {
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content

    @State private var dragOffset: CGPoint = .zero
    @State private var lastDragOffset: CGPoint = .zero

    private var workspaceDragOffset: CGPoint {
        return dragOffset + lastDragOffset
    }

    var body: some View {
        ZStack {
            content()
        }
        .gesture(
            DragGesture()
                .onChanged { model in
                    dragOffset = .init(x: model.translation.width, y: model.translation.height)
                    offset = workspaceDragOffset
                }
                .onEnded { model in
                    lastDragOffset = lastDragOffset + .init(x: model.translation.width,
                                                            y: model.translation.height)
                    dragOffset = .zero
                    offset = workspaceDragOffset
                }
        )
    }
}
