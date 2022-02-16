// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppCore",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "AppCore",
            targets: ["AppCore"]),
    ],
    dependencies: [
        .package(path: "../AppState"),
        .package(path: "../RootFeature"),
        .package(path: "../LoginFeature"),
        .package(path: "../RegistrationFeature"),
        .package(path: "../TabBarFeature"),
        .package(path: "../WelcomeFeature")
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                "AppState",
                "RootFeature",
                "LoginFeature",
                "RegistrationFeature",
                "TabBarFeature",
                "WelcomeFeature"
            ]),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]),
    ]
)
