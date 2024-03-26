//  BaseNodeView.swift
//  Created by Aiur Arkhipov on 26.03.2024.

import SwiftUI

struct BaseNodeView<Display: View>: View {
    @ObservedObject var model: BaseNode
    var onLinkTap: (NodeParam) -> Void?
    
    @ViewBuilder var display: () -> Display
    
    func links(count: Int, isInput: Bool) -> some View {
        VStack {
            ForEach(0..<count, id: \.self) { idx in
                LinkPointView {
                    LinkBadge(allowedTypes: model.allowedTypes(index: idx, isInput: isInput)).view
                } onTap: {
                    isInput ? onLinkTap(.input(model.model, idx)) : onLinkTap(.output(model.model, idx))
                } onPositionChange: { newPosition in
                    model.linkPosition["\(model.linkPositionPerfix(isInput: isInput))\(idx)"] = newPosition
                }
            }
        }
    }
    
    var body: some View {
        HStack {
            links(count: model.model.inputsCount, isInput: true)
            Spacer(minLength: 0)
            display()
            Spacer(minLength: 0)
            links(count: model.model.outputsCount, isInput: false)
        }
        .padding(.vertical, 8)
    }
}

private extension BaseNode {
    func allowedTypes(index: Int, isInput: Bool) -> [String] {
        isInput ? model.allowedInputTypes(index) : model.allowedOutputTypes(index)
    }
    
    func linkPositionPerfix(isInput: Bool) -> String {
        isInput ? "input" : "output"
    }
}
