//  DebugView.swift
//  Created by Aiur Arkhipov on 27.02.2024.

import SwiftUI

struct DebugView: View {
    @ObservedObject var controller: DebugMenuController
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Reset") {
                controller.reset()
            }
            .buttonStyle(.borderedProminent)
            Button("Add random node") {
                controller.addRandomNode()
            }
            .buttonStyle(.borderedProminent)
            Divider()
            ForEach(NodeType.allTypes, id: \.name) { item in
                Button(item.name) {
                    controller.addNode(item.type.init())
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.horizontal)
    }
}
