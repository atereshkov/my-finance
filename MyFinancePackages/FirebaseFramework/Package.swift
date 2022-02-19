// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseFramework",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "FirebaseFramework",
            targets: ["FirebaseFramework"]),
    ],
    dependencies: [
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.0.0"),
    ],
    targets: [
        .target(
            name: "FirebaseFramework",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "Firebase"),
            ]),
        .testTarget(
            name: "FirebaseFrameworkTests",
            dependencies: ["FirebaseFramework"]),
    ]
)
