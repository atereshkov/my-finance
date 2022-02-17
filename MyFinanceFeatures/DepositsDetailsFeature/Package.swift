// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DepositsDetailsFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "DepositsDetailsFeature",
            targets: ["DepositsDetailsFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DepositsDetailsFeature",
            dependencies: []),
        .testTarget(
            name: "DepositsDetailsFeatureTests",
            dependencies: ["DepositsDetailsFeature"]),
    ]
)
