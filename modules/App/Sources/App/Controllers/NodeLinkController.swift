//
//  File.swift
//  
//
//  Created by Aiur Arkhipov on 19.02.2024.
//

import SwiftUI
import Logic
import Combine

class NodeLinkController: ObservableObject {
    @Published var points: [Link] = []
    
    private var tappedPoint: Binding<CGPoint>?
    private var tappedID: String?
    
    private var tappedParam: NodeParam?
    
    var randomLetterNode = RandomLetterNode(model: RandomLetter())
    var displayNode = DisplayNode(model: Display())
    
    func addPoint(_ point: Binding<CGPoint>, id: String, param: NodeParam) {
        if let tappedParam {
            switch (tappedParam, param) {
            case (.input(let input), .output(let output)):
                /// Link output -> input
                print("321")
                displayNode.model.linkInput(output)
            case (.output(let output), .input(let input)):
                /// Link output -> input
                print("123")
            default: 
                tappedParam = nil
            }
        } else {
            tappedParam = param
        }
        
        if let tappedPoint {
            if tappedID == id {
                return
            }
            points.append(Link(from: tappedPoint, to: point))
            self.tappedPoint = nil
            self.tappedID = nil
        } else {
            tappedPoint = point
            tappedID = id
        }
    }
    
    func connectRandomLetterToDisplay() {
        displayNode.model.linkInput(randomLetterNode.model.output)
    }
    
}
