// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "App",
            targets: ["App"]),
    ],
    dependencies: [
        .package(name: "Logic", path: "../Logic")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: ["Logic"]),
        .testTarget(
            name: "AppTests",
            dependencies: ["App"]),
    ]
)
