//  LinkBadge.swift
//  Created by Igor Manakov on 07.03.2024.

import SwiftUI

struct LinkBadge {
    let allowedTypes: [String]

    @ViewBuilder
    var view: some View {
        if allowedTypes.count > 1 {
            BadgeBackground()
        } else if let type = allowedTypes.first {
            switch type {
            case "i":
                Color.blue.clipShape(.circle)
            case "s":
                Color.red.clipShape(.circle)
            case "b":
                Color.green.clipShape(.circle)
            default:
                Image(uiImage: .init(systemName: "xmark")!)
            }
        } else {
            Color(.orange)
        }
    }
}
