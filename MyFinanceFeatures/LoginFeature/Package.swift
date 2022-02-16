// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "LoginFeature",
            targets: ["LoginFeature"]),
    ],
    dependencies: [
        .package(path: "../MyFinanceComponentsKit")
    ],
    targets: [
        .target(
            name: "LoginFeature",
            dependencies: ["MyFinanceComponentsKit"]),
        .testTarget(
            name: "LoginFeatureTests",
            dependencies: ["LoginFeature"]),
    ]
)
