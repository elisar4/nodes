//  JoinNodeView.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

final class JoinNode: BaseNode, ObservableObject {
    var model: Join
    var name: String = "Join"
    var id: String = UUID().uuidString

    required init() { model = .init() }

    func build(controller: LinkController, id: String) -> AnyView {
        AnyView(JoinDisplayNodeBodyView(model: self, onLinkTap: { (point, param) in
            controller.addPoint(point, id: id, param: param)
        }))
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
