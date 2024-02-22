//  MainView.swift
//  Created by Vladimir Roganov on 13.02.2024

import SwiftUI
import Logic

struct MainView: View {
    @StateObject var controller = NodeLinkController()
    
    var body: some View {
        ZStack {
            NodeView(title: "RandomLetterNode") { id in
                RandomLetterNodeBodyView(model: controller.randomLetterNode) { point in
                    controller.addPoint(point, id: id)
                    controller.connectRandomLetterToDisplay()
                    return nil
                }
            }
            NodeView(title: "DisplayNode") { id in
                TextDisplayNodeBodyView(displayModel: controller.displayNode) { (point, param) in
                    controller.addPoint(point, id: id)
                }
            }
            NodeView(title: "TextFieldNode") { id in
                TextFieldNodeBodyView() { point in
                    controller.addPoint(point, id: id)
                }
            }
//            NodeView(title: "TextFieldNode") { id in
//                TextDisplayNodeBodyView(text: "Hello") { point in
//                    controller.addPoint(point, id: id)
//                }
//            }
            
            ForEach(controller.points) { element in
                LinkView(fromPoint: element.from, toPoint: element.to)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

