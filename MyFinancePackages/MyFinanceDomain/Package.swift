// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyFinanceDomain",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "MyFinanceDomain",
            targets: ["MyFinanceDomain"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MyFinanceDomain",
            dependencies: []),
        .testTarget(
            name: "MyFinanceDomainTests",
            dependencies: ["MyFinanceDomain"]),
    ]
)
