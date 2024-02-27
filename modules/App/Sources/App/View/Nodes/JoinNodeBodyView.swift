//  JoinNodeView.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

class JoinNode: ObservableObject {
    var model: Join
    
    init(model: Join) {
        self.model = model
    }
}

struct JoinDisplayNodeBodyView: View {
    @ObservedObject var model: JoinNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?
    
    var body: some View {
        HStack {
            VStack {
                LinkPointView(onTap: { onLinkTap($0, .input(model.model, 0)) })
                LinkPointView(onTap: { onLinkTap($0, .input(model.model, 1)) })
            }

            Spacer(minLength: 0)
            LinkPointView(onTap: { onLinkTap($0, .output(model.model.output)) })
        }
        .padding(.vertical, 8)
    }
}
