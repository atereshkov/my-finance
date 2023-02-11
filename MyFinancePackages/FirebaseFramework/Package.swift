// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseFramework",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "FirebaseFramework",
            targets: ["FirebaseFramework"]),
    ],
    dependencies: [
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.5.0"),
    ],
    targets: [
        .target(
            name: "FirebaseFramework",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "Firebase"),
                .product(name: "FirebaseAuth", package: "Firebase")
            ]),
        .testTarget(
            name: "FirebaseFrameworkTests",
            dependencies: ["FirebaseFramework"]),
    ]
)
