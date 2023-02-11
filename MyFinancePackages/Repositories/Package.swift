// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repositories",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "Repositories",
            targets: ["Repositories"]),
    ],
    dependencies: [
        .package(path: "../FirebaseFramework"),
        .package(path: "../MyFinanceDomain")
    ],
    targets: [
        .target(
            name: "Repositories",
            dependencies: [
                "FirebaseFramework",
                "MyFinanceDomain"
            ]),
        .testTarget(
            name: "RepositoriesTests",
            dependencies: ["Repositories"]),
    ]
)
