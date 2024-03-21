//  LinkPointView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct LinkPointView<Content: View>: View {
    @State private var point: CGPoint = .zero
    @ViewBuilder var pointView: () -> Content
    var onTap: () -> Void?
    var onPositionChange: (CGPoint) -> Void

    var body: some View {
        GeometryReader { geo in
            pointView()
                .contentShape(Rectangle())
                .onAppear {
                    let frame = geo.frame(in: .named("ZStackMain"))
                    onPositionChange(.init(x: frame.midX, y: frame.midY))
                }
                .onChange(of: geo.frame(in: .global)) {
                    let frame = geo.frame(in: .named("ZStackMain"))
                    onPositionChange(.init(x: frame.midX, y: frame.midY))
                }
        }
        .frame(width: 20, height: 20)
        .fixedSize()
        .onTapGesture {
            onTap()
        }
    }
}


struct LinkPointView_Previews: PreviewProvider {
    static var previews: some View {
        LinkPointView {
            Color.blue.clipShape(.circle)
        } onTap: {
            
        } onPositionChange: { _ in

        }
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .previewDisplayName("Default preview")

    }
}
