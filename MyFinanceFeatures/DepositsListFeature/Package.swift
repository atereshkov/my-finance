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
    dependencies: [
        .package(path: "../MyFinanceComponentsKit"),
        .package(path: "../MyFinanceAssetsKit"),
        .package(path: "../MyFinanceDomain"),
        .package(path: "../AppState")
    ],
    targets: [
        .target(
            name: "DepositsListFeature",
            dependencies: [
                "MyFinanceComponentsKit",
                "MyFinanceAssetsKit",
                "MyFinanceDomain",
                "AppState"
            ]),
        .testTarget(
            name: "DepositsListFeatureTests",
            dependencies: ["DepositsListFeature"]
        ),
    ]
)
