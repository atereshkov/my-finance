// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppState",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "AppState",
            targets: ["AppState"]),
    ],
    dependencies: [
        .package(path: "../MyFinanceDomain")
    ],
    targets: [
        .target(
            name: "AppState",
            dependencies: [
                "MyFinanceDomain"
            ]),
        .testTarget(
            name: "AppStateTests",
            dependencies: ["AppState"]),
    ]
)
