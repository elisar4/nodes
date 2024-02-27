//  MainView.swift
//  Created by Vladimir Roganov on 13.02.2024

import SwiftUI
import Logic

struct MainView: View {
    @StateObject var controller = NodeLinkController()
    
    var body: some View {
        ZStack {
            ForEach(controller.nodes, id: \.id) { node in
                NodeView(title: node.name) { id in
                    node.build(controller: controller, id: id)
                }
            }
            ForEach(controller.points) { element in
                LinkView(fromPoint: element.from, toPoint: element.to)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

