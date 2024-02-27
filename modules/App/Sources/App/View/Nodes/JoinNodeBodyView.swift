//  JoinNodeView.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

class JoinNode: ObservableObject {
    var model: Display
    
    @Published var text: String?
    
    init(model: Display) {
        self.model = model
        model.action = { [weak self] in
            self?.text = $0
        }
    }
}

struct JoinDisplayNodeBodyView: View {
    @ObservedObject var displayModel: DisplayNode
    var onLinkTap: (Binding<CGPoint>) -> Void?
    
    var body: some View {
        HStack {
            LinkPointView(onTap: onLinkTap)
            Spacer(minLength: 0)
            Text(displayModel.text ?? "nil")
            Spacer(minLength: 0)
            LinkPointView(onTap: onLinkTap)
        }
        .padding(.vertical, 8)
    }
}
