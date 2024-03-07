//  LinkPointView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct Point: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct LinkPointView<Content: View>: View {
    @State private var point: CGPoint = .zero
    @ViewBuilder var pointView: () -> Content
    var onTap: (Binding<CGPoint>) -> Void?

    var body: some View {
        GeometryReader { geo in
            pointView()
                .contentShape(Rectangle())
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


struct LinkPointView_Previews: PreviewProvider {
    static var previews: some View {
        LinkPointView {
            Point().fill(.blue)
        } onTap: {_ in
            return
        }
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .previewDisplayName("Default preview")

    }
}
