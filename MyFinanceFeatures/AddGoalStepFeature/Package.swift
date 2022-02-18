// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AddGoalStepFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "AddGoalStepFeature",
            targets: ["AddGoalStepFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AddGoalStepFeature",
            dependencies: []),
        .testTarget(
            name: "AddGoalStepFeatureTests",
            dependencies: ["AddGoalStepFeature"]),
    ]
)
