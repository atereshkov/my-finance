// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DepositsListFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "DepositsListFeature",
            targets: ["DepositsListFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DepositsListFeature",
            dependencies: []),
        .testTarget(
            name: "DepositsListFeatureTests",
            dependencies: ["DepositsListFeature"]),
    ]
)
