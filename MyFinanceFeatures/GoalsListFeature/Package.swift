// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GoalsListFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "GoalsListFeature",
            targets: ["GoalsListFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GoalsListFeature",
            dependencies: []),
        .testTarget(
            name: "GoalsListFeatureTests",
            dependencies: ["GoalsListFeature"]),
    ]
)
