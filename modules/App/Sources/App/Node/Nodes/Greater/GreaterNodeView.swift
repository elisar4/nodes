//  GreaterNodeView.swift
//  Created by Vladimir Roganov on 07.03.2024

import SwiftUI

struct GreaterNodeView: View {
    @ObservedObject var model: GreaterNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            VStack {
                LinkPointView {
                    LinkBadge(allowedTypes: model.model.allowedInputTypes(0)).view
                } onTap: { onLinkTap($0, .input(model.model, 0)) }
                LinkPointView {
                    LinkBadge(allowedTypes: model.model.allowedInputTypes(1)).view
                } onTap: { onLinkTap($0, .input(model.model, 1)) }
            }
            Spacer(minLength: 0)
            VStack {
                LinkPointView {
                    LinkBadge(allowedTypes: model.model.allowedOutputTypes(0)).view
                } onTap: { onLinkTap($0, .output(model.model.output1)) }
                LinkPointView {
                    LinkBadge(allowedTypes: model.model.allowedOutputTypes(1)).view
                } onTap: { onLinkTap($0, .output(model.model.output2)) }
            }
        }
        .padding(.vertical, 8)
    }
}
