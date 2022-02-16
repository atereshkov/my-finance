// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RootFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "RootFeature",
            targets: ["RootFeature"]),
    ],
    dependencies: [
        .package(path: "../AppState"),
    ],
    targets: [
        .target(
            name: "RootFeature",
            dependencies: ["AppState"]),
        .testTarget(
            name: "RootFeatureTests",
            dependencies: ["RootFeature"]),
    ]
)
