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
    dependencies: [
        .package(path: "../MyFinanceAssetsKit"),
        .package(path: "../MyFinanceDomain"),
        .package(path: "../MyFinanceComponentsKit"),
        .package(path: "../AppState")
    ],
    targets: [
        .target(
            name: "GoalsListFeature",
            dependencies: [
                "MyFinanceAssetsKit",
                "MyFinanceDomain",
                "MyFinanceComponentsKit",
                "AppState"
            ]),
        .testTarget(
            name: "GoalsListFeatureTests",
            dependencies: ["GoalsListFeature"]),
    ]
)
