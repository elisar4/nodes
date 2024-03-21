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
            LinkPointView {
                LinkBadge(allowedTypes: model.model.allowedOutputTypes(0)).view
            } onTap: {
                onLinkTap(.output(model.model, 0))
            } onPositionChange: { newPosition in
                model.linkPosition["output0"] = newPosition
            }
        }
        .padding(.vertical, 8)
    }
}

