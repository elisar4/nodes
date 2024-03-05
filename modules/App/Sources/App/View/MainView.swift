//  MainView.swift
//  Created by Vladimir Roganov on 13.02.2024

import SwiftUI
import Logic

struct MainView: View {
    @StateObject var controller = NodeLinkController()

    var body: some View {
        WorkspaceOffset(offset: $controller.workspaceDragOffset) {
            NavigationView {
                DebugView(controller: controller)
                GeometryReader { geometry in
                    workspace(windowSize: geometry.frame(in: .local).size)
                }
            }
        }
    }

    private func workspace(windowSize: CGSize) -> some View {
        ZStack {
            WorkspaceBackground(windowSize: windowSize, workspaceOffset: controller.workspaceDragOffset)
                .onTapGesture {
                    controller.didTapBackground()
                }
            ForEach(controller.nodes, id: \.id) { node in
                makeNodeView(node)
            }
            .offset(CGSize(width: controller.workspaceDragOffset.x, height: controller.workspaceDragOffset.y))
            ForEach(controller.points) { element in
                LinkView(fromPoint: element.from, toPoint: element.to)
                    .zIndex(2)
            }
        }
        .coordinateSpace(name: "ZStackMain")
        .toolbar(content: { toolbarView })
        .ignoresSafeArea(.keyboard)
    }

    private func makeNodeView(_ node: any BaseNode) -> some View {
        let tap = TapGesture()
            .onEnded { _ in
                controller.didTapNode(node)
            }
        let drag = DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                node.position = .init(x: gesture.location.x,
                                      y: gesture.location.y)
                controller.topNodeID = node.id
            }
        return NodeView(title: node.name, isSelected: controller.selection?.id == node.id, position: node.position) {
            node.build(controller: controller, id: node.id)
        }
        .zIndex(controller.topNodeID == node.id ? 1 : 0)
        .gesture(drag.simultaneously(with: tap))
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
