//  SUITest.swift
//  Created by Vladimir Roganov on 13.02.2024

import SwiftUI

struct SUITest: View {
    @State var point1: CGPoint = CGPoint.zero
    @State var point2: CGPoint = CGPoint.zero
    @State var point3: CGPoint = CGPoint.zero

    var body: some View {
        ZStack {
            NodeView(title: "TextFieldNode") {
                TextFieldNodeBodyView(outputPoint: $point1)
            }
            NodeView(title: "TextFieldNode") {
                TextDisplayNodeBodyView(text: "Hello", inputPoint: $point2, outputPoint: $point3)
            }
            
            Path() { path in
                path.move(to: point1)
                path.addLine(to: point2)
            }
            .stroke(.blue, lineWidth: 2)
            .ignoresSafeArea()
        }
        .ignoresSafeArea(.keyboard)
    }
}
