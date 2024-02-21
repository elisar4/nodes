// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Logic",
    products: [
        .library(
            name: "Logic",
            targets: ["Logic"]),
    ],
    targets: [
        .target(
            name: "Logic"),
        .testTarget(
            name: "LogicTests",
            dependencies: ["Logic"]),
    ]
)
