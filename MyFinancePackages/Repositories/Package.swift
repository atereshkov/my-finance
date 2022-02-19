// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repositories",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "Repositories",
            targets: ["Repositories"]),
    ],
    dependencies: [
        .package(path: "../FirebaseFramework")
    ],
    targets: [
        .target(
            name: "Repositories",
            dependencies: [
                "FirebaseFramework"
            ]),
        .testTarget(
            name: "RepositoriesTests",
            dependencies: ["Repositories"]),
    ]
)
