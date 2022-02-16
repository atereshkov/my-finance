// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WelcomeFeature",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "WelcomeFeature",
            targets: ["WelcomeFeature"]),
    ],
    dependencies: [
        .package(path: "../MyFinanceComponentsKit"),
        .package(path: "../AppState")
    ],
    targets: [
        .target(
            name: "WelcomeFeature",
            dependencies: ["MyFinanceComponentsKit", "AppState"]),
        .testTarget(
            name: "WelcomeFeatureTests",
            dependencies: ["WelcomeFeature"]),
    ]
)
