//  NodeView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct NodeView<Content: View>: View, Identifiable {
    @State var title: String

    @State private var isShowBody: Bool = true
    @State private var position = CGPoint.zero

    @ViewBuilder var content: (String) -> Content

    var id: String = UUID().uuidString

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                NodeHeaderView(isShowBody: $isShowBody, title: title)
                    .transition(.scale)
                if isShowBody {
                    content(id)
                }
            }
            .frame(minWidth: 0, idealWidth: 200, minHeight: 0)
            .fixedSize()
            .background(.background)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke())
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
}
