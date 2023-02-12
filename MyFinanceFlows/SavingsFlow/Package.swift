// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SavingsFlow",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "SavingsFlow",
            targets: ["SavingsFlow"]),
    ],
    dependencies: [
        .package(path: "../../MyFinancePackages/MyFinanceComponentsKit"),
        .package(path: "../../MyFinancePackages/MyFinanceAssetsKit"),
        .package(path: "../../MyFinancePackages/MyFinanceDomain"),
        .package(path: "../../MyFinancePackages/AppState"),
        .package(path: "../../MyFinancePackages/Repositories")
    ],
    targets: [
        .target(
            name: "SavingsFlow",
            dependencies: [
                "MyFinanceComponentsKit",
                "MyFinanceAssetsKit",
                "MyFinanceDomain",
                "AppState",
                "Repositories"
            ]),
        .testTarget(
            name: "SavingsFlowTests",
            dependencies: ["SavingsFlow"]),
    ]
)
