// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SavingsListFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "SavingsListFeature",
            targets: ["SavingsListFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SavingsListFeature",
            dependencies: []),
        .testTarget(
            name: "SavingsListFeatureTests",
            dependencies: ["SavingsListFeature"]),
    ]
)
