//  Link.swift
//  Created by Aiur Arkhipov on 19.02.2024.

import SwiftUI

struct LinkView: View {
    @Binding var fromPoint: CGPoint
    @Binding var toPoint: CGPoint
    
    var body: some View {
        Path() { path in
            path.move(to: fromPoint)
            path.addLine(to: toPoint)
        }
        .stroke(.blue, lineWidth: 2)
    }
}
