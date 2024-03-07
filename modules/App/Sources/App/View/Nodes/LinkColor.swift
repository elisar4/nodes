//  LinkColor.swift
//  Created by Igor Manakov on 07.03.2024.

import SwiftUI

struct LinkColor {
    let allowedTypes: [String]

    @ViewBuilder
    var view: some View {
        if allowedTypes.count > 1 {
            BadgeBackground()
        } else if let type = allowedTypes.first {
            switch type {
            case "i":
                Point().fill(.blue)
            case "s":
                Point().fill(.red)
            default:
                Point().fill(.red)
            }
        } else {
            Color(.orange)
        }
    }
}
