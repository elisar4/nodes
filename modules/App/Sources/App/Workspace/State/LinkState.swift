//  LinkState.swift
//  Created by Vladimir Roganov on 21.03.2024

import Foundation

protocol LinkState {
    var id: String { get }
    var fromId: String { get }
    var toId: String { get }
    var toPosition: Int { get }
}

extension Link: LinkState {}
