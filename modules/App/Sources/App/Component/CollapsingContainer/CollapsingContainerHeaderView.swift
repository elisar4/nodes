//  CollapsingContainerHeaderView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI

struct CollapsingContainerHeaderView: View {
    @Binding var isShowBody: Bool
    @State var title: String

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    isShowBody.toggle()
                }
            } label: {
                if isShowBody {
                    Image(systemName: "chevron.down")
                } else {
                    Image(systemName: "chevron.right")
                }
            }
            .frame(width: 20, height: 20)
            .fixedSize()
            Text(title)

            Spacer()
        }
        .padding()
        .background(.bar)
    }
}
