//
//  File.swift
//  
//
//  Created by Aiur Arkhipov on 19.02.2024.
//

import SwiftUI

class NodeLinkController: ObservableObject {
    @Published var points: [Link] = []
    
    private var tappedPoint: Binding<CGPoint>?
    private var tappedID: String?
    
    func addPoint(_ point: Binding<CGPoint>, id: String) {
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
}
