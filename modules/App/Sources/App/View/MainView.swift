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
            NodeView(title: "RandomLetterNode") { id in
                RandomLetterNodeBodyView(model: controller.randomLetterNode) { (point, param) in
                    controller.addPoint(point, id: id, param: param)
                }
            }
            NodeView(title: "DisplayNode") { id in
                TextDisplayNodeBodyView(displayModel: controller.displayNode) { (point, param) in
                    controller.addPoint(point, id: id, param: param)
                }
            }
            ForEach(controller.points) { element in
                LinkView(fromPoint: element.from, toPoint: element.to)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

