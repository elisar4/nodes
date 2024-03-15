//  DisplayNodeView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct DisplayNodeView: View {
    @ObservedObject var model: DisplayNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            LinkPointView {
                LinkBadge(allowedTypes: model.model.allowedInputTypes(0)).view
            } onTap: {
                onLinkTap($0, .input(model.model, 0))
            }
            Spacer(minLength: 0)
            Text(model.text ?? "nil")
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
