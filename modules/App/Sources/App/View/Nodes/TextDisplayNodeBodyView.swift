//  TextDisplayNodeBodyView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct TextDisplayNodeBodyView: View {
    @State var text: String
    var onLinkTap: (Binding<CGPoint>) -> Void?

    var body: some View {
        HStack {
            LinkPointView(onTap: onLinkTap)
            Spacer(minLength: 0)
            Text(text)
            Spacer(minLength: 0)
            LinkPointView(onTap: onLinkTap)
        }
        .padding(.vertical, 8)
    }
}
