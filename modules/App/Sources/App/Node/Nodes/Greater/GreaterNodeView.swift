//  GreaterNodeView.swift
//  Created by Vladimir Roganov on 07.03.2024

import SwiftUI

struct GreaterNodeView: View {
    @ObservedObject var model: GreaterNode
    var onLinkTap: (NodeParam) -> Void?

    var body: some View {
        HStack {
            VStack {
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
            }
            Spacer(minLength: 0)
            VStack {
                LinkPointView {
                    LinkBadge(allowedTypes: model.model.allowedOutputTypes(0)).view
                } onTap: {
                    onLinkTap(.output(model.model, 0))
                } onPositionChange: { newPosition in
                    model.linkPosition["output0"] = newPosition
                }
                LinkPointView {
                    LinkBadge(allowedTypes: model.model.allowedOutputTypes(1)).view
                } onTap: {
                    onLinkTap(.output(model.model, 1))
                } onPositionChange: { newPosition in
                    model.linkPosition["output1"] = newPosition
                }
            }
        }
        .padding(.vertical, 8)
    }
}
