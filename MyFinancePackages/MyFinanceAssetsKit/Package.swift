// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyFinanceAssetsKit",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "MyFinanceAssetsKit",
            targets: ["MyFinanceAssetsKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MyFinanceAssetsKit",
            dependencies: []),
        .testTarget(
            name: "MyFinanceAssetsKitTests",
            dependencies: ["MyFinanceAssetsKit"]),
    ]
)
