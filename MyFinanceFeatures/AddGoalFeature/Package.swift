// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AddGoalFeature",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "AddGoalFeature",
            targets: ["AddGoalFeature"]),
    ],
    dependencies: [
        .package(path: "../AppState"),
        .package(path: "../Repositories"),
        .package(path: "../MyFinanceDomain")
    ],
    targets: [
        .target(
            name: "AddGoalFeature",
            dependencies: [
                "AppState",
                "Repositories",
                "MyFinanceDomain"
            ]),
        .testTarget(
            name: "AddGoalFeatureTests",
            dependencies: ["AddGoalFeature"]),
    ]
)
