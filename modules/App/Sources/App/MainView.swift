//  MainView.swift
//  Created by Vladimir Roganov on 13.02.2024

import SwiftUI
import Logic

struct MainView: View {
    @ObservedObject var controller: WorkspaceController
    @ObservedObject var debugController: DebugMenuController

    init(controller: WorkspaceController, debugController: DebugMenuController) {
        self.controller = controller
        self.debugController = debugController
    }

    var body: some View {
        NavigationView {
            DebugView(controller: debugController)
            WorkspaceOffset(offset: $controller.workspaceDragOffset) {
                workspace()
            }
        }
    }

    private func workspace() -> some View {
        ZStack {
            WorkspaceBackground(offset: controller.workspaceDragOffset)
                .onTapGesture {
                    controller.didTapBackground()
                }
            ForEach(controller.nodes, id: \.id) { node in
                makeNodeView(node)
            }
            .offset(CGSize(width: controller.workspaceDragOffset.x, height: controller.workspaceDragOffset.y))
            ForEach(controller.links) { element in
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
        return CollapsingContainerView(title: node.name, isSelected: controller.selection?.id == node.id, position: node.position) {
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
