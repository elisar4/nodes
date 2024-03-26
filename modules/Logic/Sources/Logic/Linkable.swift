//  Linkable.swift
//  Created by Igor Manakov on 27.02.2024.

public protocol Linkable {
    func allowedInputTypes(_ position: Int) -> [String]
    func allowedOutputTypes(_ position: Int) -> [String]
}

public protocol Removable {
    func remove()
}

public protocol Runnable {
    func run()
}
