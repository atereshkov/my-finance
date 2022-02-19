// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AddGoalFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "AddGoalFeature",
            targets: ["AddGoalFeature"]),
    ],
    dependencies: [
        .package(path: "../AppState")
    ],
    targets: [
        .target(
            name: "AddGoalFeature",
            dependencies: [
                "AppState"
            ]),
        .testTarget(
            name: "AddGoalFeatureTests",
            dependencies: ["AddGoalFeature"]),
    ]
)
