// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthFlow",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "AuthFlow",
            targets: ["AuthFlow"]),
    ],
    dependencies: [
        .package(path: "../../MyFinancePackages/MyFinanceComponentsKit")
    ],
    targets: [
        .target(
            name: "AuthFlow",
            dependencies: ["MyFinanceComponentsKit"]),
        .testTarget(
            name: "AuthFlowTests",
            dependencies: ["AuthFlow"]),
    ]
)
