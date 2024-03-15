//  RandomLetterNodeView.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI

struct RandomLetterNodeView: View {
    @ObservedObject var model: RandomLetterNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

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
                onLinkTap($0, .output(model.model.output))
            }
        }
        .padding(.vertical, 8)
    }
}
