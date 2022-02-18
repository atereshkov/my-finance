// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EditGoalFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "EditGoalFeature",
            targets: ["EditGoalFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "EditGoalFeature",
            dependencies: []),
        .testTarget(
            name: "EditGoalFeatureTests",
            dependencies: ["EditGoalFeature"]),
    ]
)
