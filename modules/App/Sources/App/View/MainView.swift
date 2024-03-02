//  MainView.swift
//  Created by Vladimir Roganov on 13.02.2024

import SwiftUI
import Logic

struct MainView: View {
    @StateObject var controller = NodeLinkController()

    var body: some View {
        NavigationView {
            DebugView(controller: controller)
            ZStack {
                workspaceBackground
                ForEach(controller.nodes, id: \.id) { node in
                    NodeView(title: node.name, isSelected: controller.selection?.id == node.id) {
                        node.build(controller: controller, id: node.id)
                    }
                    .onTapGesture {
                        controller.didTapNode(node)
                    }
                }
                ForEach(controller.points) { element in
                    LinkView(fromPoint: element.from, toPoint: element.to)
                }
            }
            .toolbar(content: { toolbarView })
            .ignoresSafeArea(.keyboard)
        }
    }

    var workspaceBackground: some View {
        Image("bgPattern")
            .resizable(resizingMode: .tile)
            .onTapGesture {
                controller.didTapBackground()
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
