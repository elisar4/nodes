//  TextFieldNodeBodyView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct TextFieldNodeBodyView: View {
    @State var text: String = ""
    var onLinkTap: (Binding<CGPoint>) -> Void?

    var body: some View {
        HStack {
            TextField("Hello", text: $text)
            LinkPointView(onTap: onLinkTap)
        }
        .padding(.leading, 8)
        .padding(.vertical, 8)
    }
}
