// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Listeners",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "Listeners",
            targets: ["Listeners"]),
    ],
    dependencies: [
        .package(path: "../FirebaseFramework"),
        .package(path: "../AppState"),
        .package(path: "../MyFinanceDomain")
    ],
    targets: [
        .target(
            name: "Listeners",
            dependencies: [
                "FirebaseFramework",
                "AppState",
                "MyFinanceDomain"
            ]),
        .testTarget(
            name: "ListenersTests",
            dependencies: ["Listeners"]),
    ]
)
