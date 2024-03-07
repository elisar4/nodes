//  CGPoint+Add.swift
//  Created by Vladimir Roganov on 05.03.2024

import Foundation

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}
