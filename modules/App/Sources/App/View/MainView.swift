//  MainView.swift
//  Created by Vladimir Roganov on 13.02.2024

import SwiftUI
import Logic

struct MainView: View {
    @StateObject var controller = NodeLinkController()
    @State private var offset: CGPoint = .zero
    @State private var lastOffset: CGPoint = .zero

    private var workspaceDragOffset: CGPoint {
        return offset + lastOffset
    }

    var body: some View {
        NavigationView {
            DebugView(controller: controller)

            GeometryReader { geometry in
                workspace(windowSize: geometry.frame(in: .local).size)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { model in
                    offset = .init(x: model.translation.width, y: model.translation.height)
                }
                .onEnded { model in
                    lastOffset = lastOffset + .init(x: model.translation.width, y: model.translation.height)
                    offset = .zero
                }
        )
    }

    private func workspace(windowSize: CGSize) -> some View {
        ZStack {
            WorkspaceBackground(windowSize: windowSize, workspaceOffset: workspaceDragOffset)
                .onTapGesture {
                    controller.didTapBackground()
                }
            ForEach(controller.nodes, id: \.id) { node in
                makeNodeView(node)
            }
            ForEach(controller.points) { element in
                LinkView(fromPoint: element.from, toPoint: element.to)
                    .zIndex(2)
            }
        }
        .position(workspaceDragOffset)
        .coordinateSpace(name: "ZStackMain")
        .toolbar(content: { toolbarView })
        .ignoresSafeArea(.keyboard)
        .onAppear {
            lastOffset = .init(x: windowSize.width * 0.5, y: windowSize.height * 0.5)
        }
    }

    private func makeNodeView(_ node: any BaseNode) -> some View {
        NodeView(title: node.name, isSelected: controller.selection?.id == node.id) {
            node.build(controller: controller, id: node.id)
        } onInteraction: {
            controller.topNodeID = node.id
        }
        .zIndex(controller.topNodeID == node.id ? 1 : 0)
        .onTapGesture {
            controller.didTapNode(node)
        }
    }

    @ViewBuilder
    var toolbarView: some View {
        if controller.selection == nil {
            EmptyView()
        } else {
            Button("Remove selected") {
                controller.removeSelectedNode()
            }
        }
    }
}

