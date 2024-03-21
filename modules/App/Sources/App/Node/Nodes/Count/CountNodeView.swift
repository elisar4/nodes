//  CountNodeView.swift
//  Created by Igor Manakov on 04.03.2024.

import SwiftUI

struct CountNodeView: View {
    @ObservedObject var model: CountNode
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
