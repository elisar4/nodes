//  DebugView.swift
//  Created by Aiur Arkhipov on 27.02.2024.

import SwiftUI

struct DebugView: View {
    @ObservedObject var controller: NodeLinkController

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
            ForEach(controller.nodesNameTypePair, id: \.0) { nodePair in
                Button(nodePair.0) {
                    controller.addNode(nodePair.1.init())
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.horizontal)
    }
}
