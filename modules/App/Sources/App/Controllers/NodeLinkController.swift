//  NodeLinkController.swift
//  Created by Aiur Arkhipov on 19.02.2024.

import SwiftUI
import Logic
import Combine

final class NodeLinkController: LinkController, ObservableObject {
    @Published var points: [Link] = []
    @Published var nodes: [any BaseNode] = [
        JoinNode(model: Join())
    ]

    private var tappedPoint: Binding<CGPoint>?
    private var tappedID: String?
    
    private var tappedParam: NodeParam?
    
    var randomLetterNode = RandomLetterNode(model: RandomLetter())
    var displayNode = DisplayNode(model: Display())

    func addPoint(_ point: Binding<CGPoint>, id: String, param: NodeParam) {
        if let tappedParam, let tappedPoint {
            if tappedID == id {
                return
            }
            switch (tappedParam, param) {
            case (.input(let input, let position), .output(let output)):
                link(input: input, position: position, output: output, tappedPoint: tappedPoint, point: point)
            case (.output(let output), .input(let input, let position)):
                link(input: input, position: position, output: output, tappedPoint: tappedPoint, point: point)
            default:
                clear()
            }
        } else {
            tappedParam = param
            tappedPoint = point
            tappedID = id
        }
    }

    private func link(input: NodeInput, position: Int, output: PassthroughSubject<String?, Never>, tappedPoint: Binding<CGPoint>, point: Binding<CGPoint>) {
        input.linkInput(output, position: position)
        points.append(Link(from: tappedPoint, to: point))
        clear()
    }

    private func clear() {
        tappedParam = nil
        tappedPoint = nil
        tappedID = nil
    }
}
