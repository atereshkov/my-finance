// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TabBarFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "TabBarFeature",
            targets: ["TabBarFeature"]),
    ],
    dependencies: [
        .package(path: "../MyFinanceAssetsKit")
    ],
    targets: [
        .target(
            name: "TabBarFeature",
            dependencies: [
                "MyFinanceAssetsKit"
            ]),
        .testTarget(
            name: "TabBarFeatureTests",
            dependencies: ["TabBarFeature"]),
    ]
)
