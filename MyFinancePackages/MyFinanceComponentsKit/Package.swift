// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyFinanceComponentsKit",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "MyFinanceComponentsKit",
            targets: ["MyFinanceComponentsKit"]),
    ],
    dependencies: [
        .package(path: "../MyFinanceAssetsKit")
    ],
    targets: [
        .target(
            name: "MyFinanceComponentsKit",
            dependencies: [
                "MyFinanceAssetsKit"
            ]),
        .testTarget(
            name: "MyFinanceComponentsKitTests",
            dependencies: ["MyFinanceComponentsKit"]),
    ]
)
