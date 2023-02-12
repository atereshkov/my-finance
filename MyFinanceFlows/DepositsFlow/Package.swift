// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DepositsFlow",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "DepositsFlow",
            targets: ["DepositsFlow"]),
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
            name: "DepositsFlow",
            dependencies: [
                "MyFinanceComponentsKit",
                "MyFinanceAssetsKit",
                "MyFinanceDomain",
                "AppState",
                "Repositories"
            ]),
        .testTarget(
            name: "DepositsFlowTests",
            dependencies: ["DepositsFlow"]),
    ]
)
