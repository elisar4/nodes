//  LinkPointView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct LinkPointView: View {
    @State private var point: CGPoint = .zero
    var onTap: (Binding<CGPoint>) -> Void?

    var body: some View {
        GeometryReader { geo in
            Image(systemName: "circle.circle")
                .onChange(of: geo.frame(in: .global)) { _ in
                    let frame = geo.frame(in: .named("ZStackMain"))
                    point = .init(x: frame.midX, y: frame.midY)
                }
        }
        .frame(width: 20, height: 20)
        .fixedSize()
        .onTapGesture {
            onTap($point)
        }
    }
}
