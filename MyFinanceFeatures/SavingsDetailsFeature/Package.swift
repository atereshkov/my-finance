// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SavingsDetailsFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "SavingsDetailsFeature",
            targets: ["SavingsDetailsFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SavingsDetailsFeature",
            dependencies: []),
        .testTarget(
            name: "SavingsDetailsFeatureTests",
            dependencies: ["SavingsDetailsFeature"]),
    ]
)
