// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EditGoalFeature",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "EditGoalFeature",
            targets: ["EditGoalFeature"]),
    ],
    dependencies: [
        .package(path: "../AppState"),
        .package(path: "../MyFinanceDomain"),
        .package(path: "../Repositories"),
    ],
    targets: [
        .target(
            name: "EditGoalFeature",
            dependencies: [
                "AppState",
                "MyFinanceDomain",
                "Repositories"
            ]),
        .testTarget(
            name: "EditGoalFeatureTests",
            dependencies: ["EditGoalFeature"]),
    ]
)
