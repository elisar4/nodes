//  NodeView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct NodeView<Content: View>: View {
    @State var title: String
    var isSelected: Bool

    @State private var isShowBody: Bool = true
    @State private var position = CGPoint.zero

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
            .position(position)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        position = gesture.location
                    }
            )
            .onAppear {
                position = .init(x: proxy.size.width * CGFloat.random(in: 0.2...0.8),
                                 y: proxy.size.height * CGFloat.random(in: 0.2...0.8))
            }
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
