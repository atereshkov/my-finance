// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AddGoalStepFeature",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "AddGoalStepFeature",
            targets: ["AddGoalStepFeature"]),
    ],
    dependencies: [
        .package(path: "../AppState"),
        .package(path: "../Repositories"),
        .package(path: "../MyFinanceDomain")
    ],
    targets: [
        .target(
            name: "AddGoalStepFeature",
            dependencies: [
                "AppState",
                "Repositories",
                "MyFinanceDomain"
            ]),
        .testTarget(
            name: "AddGoalStepFeatureTests",
            dependencies: ["AddGoalStepFeature"]),
    ]
)
