//  NodeView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct NodeView<Content: View>: View {
    @State var title: String
    var isSelected: Bool
    var position = CGPoint.zero

    @State private var isShowBody: Bool = true

    @ViewBuilder var content: () -> Content

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                NodeHeaderView(isShowBody: $isShowBody, title: title)
                    .transition(.scale)
                if isShowBody {
                    content()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
            .fixedSize()
            .background(.background)
            .overlay(nodeBorder)
            .position(.init(x: position.x, y: position.y))
        }
    }

    private var nodeBorder: some View {
        if isSelected {
            RoundedRectangle(cornerRadius: 10).stroke(Color.accentColor)
        } else {
            RoundedRectangle(cornerRadius: 10).stroke(Color.secondary)
        }
    }
}
