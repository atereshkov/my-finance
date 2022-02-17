// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GoalDetailsFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "GoalDetailsFeature",
            targets: ["GoalDetailsFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GoalDetailsFeature",
            dependencies: []),
        .testTarget(
            name: "GoalDetailsFeatureTests",
            dependencies: ["GoalDetailsFeature"]),
    ]
)
