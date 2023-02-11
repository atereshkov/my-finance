// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RegistrationFeature",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "RegistrationFeature",
            targets: ["RegistrationFeature"]),
    ],
    dependencies: [
        .package(path: "../MyFinanceComponentsKit")
    ],
    targets: [
        .target(
            name: "RegistrationFeature",
            dependencies: ["MyFinanceComponentsKit"]),
        .testTarget(
            name: "RegistrationFeatureTests",
            dependencies: ["RegistrationFeature"]),
    ]
)
