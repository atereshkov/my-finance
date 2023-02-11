// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DepositsDetailsFeature",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "DepositsDetailsFeature",
            targets: ["DepositsDetailsFeature"]),
    ],
    dependencies: [
        .package(path: "../MyFinanceAssetsKit"),
        .package(path: "../MyFinanceComponentsKit"),
        .package(path: "../AppState"),
        .package(path: "../MyFinanceDomain"),
        .package(path: "../Repositories")
    ],
    targets: [
        .target(
            name: "DepositsDetailsFeature",
            dependencies: [
                "MyFinanceAssetsKit",
                "MyFinanceComponentsKit",
                "AppState",
                "MyFinanceDomain",
                "Repositories"
            ]),
        .testTarget(
            name: "DepositsDetailsFeatureTests",
            dependencies: ["DepositsDetailsFeature"]),
    ]
)
