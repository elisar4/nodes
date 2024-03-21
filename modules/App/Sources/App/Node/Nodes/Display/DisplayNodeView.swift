//  DisplayNodeView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct DisplayNodeView: View {
    @ObservedObject var model: DisplayNode
    var onLinkTap: (NodeParam) -> Void?

    var body: some View {
        HStack {
            LinkPointView {
                LinkBadge(allowedTypes: model.model.allowedInputTypes(0)).view
            } onTap: {
                onLinkTap(.input(model.model, 0))
            } onPositionChange: { newPosition in
                model.linkPosition["input0"] = newPosition
            }
            LinkPointView {
                LinkBadge(allowedTypes: model.model.allowedInputTypes(1)).view
            } onTap: {
                onLinkTap(.input(model.model, 1))
            } onPositionChange: { newPosition in
                model.linkPosition["input1"] = newPosition
            }

            Spacer(minLength: 0)
            Text(model.text ?? "nil")
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
