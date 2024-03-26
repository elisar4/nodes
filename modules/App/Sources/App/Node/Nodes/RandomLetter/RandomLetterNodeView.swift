//  RandomLetterNodeView.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI

struct RandomLetterNodeView: View {
    @ObservedObject var model: RandomLetterNode
    var onLinkTap: (NodeParam) -> Void?

    var body: some View {
        HStack {
            Spacer(minLength: 0)
            VStack {
                Button("Generate") {
                    model.model.run()
                }
            }
            Spacer(minLength: 0)
            VStack {
                ForEach(0..<model.model.outputsCount, id: \.self) { idx in
                    LinkPointView {
                        LinkBadge(allowedTypes: model.model.allowedOutputTypes(idx)).view
                    } onTap: {
                        onLinkTap(.output(model.model, idx))
                    } onPositionChange: { newPosition in
                        model.linkPosition["output\(idx)"] = newPosition
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}
