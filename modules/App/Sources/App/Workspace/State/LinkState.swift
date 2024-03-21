//  LinkState.swift
//  Created by Vladimir Roganov on 21.03.2024

import Foundation

protocol LinkState {
    var fromId: String { get }
    var fromPosition: Int { get }
    var toId: String { get }
    var toPosition: Int { get }
}

extension Link: LinkState {

}
extension LinkState {
    var restored: Link {
        .init(fromId: fromId,
              fromPosition: fromPosition,
              toId: toId,
              toPosition: toPosition)
    }
}
