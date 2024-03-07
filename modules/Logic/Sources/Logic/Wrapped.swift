//  Wrapped.swift
//  Created by Igor Manakov on 04.03.2024.

import Foundation

public enum Wrapped: Equatable {
    case int(Int?)
    case string(String?)

    var string: String? {
        if case let .string(value) = self {
            return value
        } else {
            return nil
        }
    }

    var int: Int? {
        if case let .int(value) = self {
            return value
        } else {
            return nil
        }
    }

    public var type: String {
        switch self {
        case .int:
            return "i"
        case .string:
            return "s"
        }
    }
}
