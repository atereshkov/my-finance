// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GoalDetailsFeature",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "GoalDetailsFeature",
            targets: ["GoalDetailsFeature"]),
    ],
    dependencies: [
        .package(path: "../MyFinanceAssetsKit"),
        .package(path: "../MyFinanceComponentsKit"),
        .package(path: "../AppState"),
        .package(path: "../MyFinanceDomain"),
        .package(path: "../Repositories")
    ],
    targets: [
        .target(
            name: "GoalDetailsFeature",
            dependencies: [
                "MyFinanceAssetsKit",
                "MyFinanceComponentsKit",
                "AppState",
                "MyFinanceDomain",
                "Repositories"
            ]),
        .testTarget(
            name: "GoalDetailsFeatureTests",
            dependencies: ["GoalDetailsFeature"]),
    ]
)
