//  Link.swift
//  Created by Aiur Arkhipov on 19.02.2024.

import SwiftUI

struct LinkPathModel: Identifiable {
    var id: String = UUID().uuidString
    var from: CGPoint
    var to: CGPoint
}

struct LinkView: View {
    var fromPoint: CGPoint
    var toPoint: CGPoint
    
    var body: some View {
        Path() { path in
            path.move(to: fromPoint)
            path.addLine(to: toPoint)
        }
        .stroke(.blue, lineWidth: 2)
    }
}
