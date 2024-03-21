//  DisplayNodeView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct DisplayNodeView: View {
    @ObservedObject var model: DisplayNode
    var onLinkTap: (NodeParam) -> Void?

    var body: some View {
        HStack {
            VStack {
                ForEach(0..<model.model.inputsCount, id: \.self) { idx in
                    LinkPointView {
                        LinkBadge(allowedTypes: model.model.allowedInputTypes(idx)).view
                    } onTap: {
                        onLinkTap(.input(model.model, idx))
                    } onPositionChange: { newPosition in
                        model.linkPosition["input\(idx)"] = newPosition
                    }
                }
            }
            Spacer(minLength: 0)
            Text(model.text ?? "nil")
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
