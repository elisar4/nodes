//  CountNodeView.swift
//  Created by Igor Manakov on 04.03.2024.

import SwiftUI

struct CountNodeView: View {
    @ObservedObject var model: CountNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            LinkPointView {
                LinkBadge(allowedTypes: model.model.allowedInputTypes(0)).view
            } onTap: {
                onLinkTap($0, .input(model.model, 0))
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
