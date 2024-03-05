//  CGPoint+InitialPosition.swift
//  Created by Vladimir Roganov on 05.03.2024

import UIKit

extension CGPoint {
    static var randomPositionOnScreen: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.width * CGFloat.random(in: 0.2...0.8),
                       y: UIScreen.main.bounds.height * CGFloat.random(in: 0.2...0.8))
    }
}
