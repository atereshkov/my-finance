// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppCore",
    platforms: [.iOS(.v16), .macOS(.v11)],
    products: [
        .library(
            name: "AppCore",
            targets: ["AppCore"]),
    ],
    dependencies: [
        .package(path: "../AppState"),
        .package(path: "../RootFeature"),
        .package(path: "../../MyFinanceFlows/AuthFlow"),
        .package(path: "../../MyFinanceFlows/DepositsFlow"),
        .package(path: "../../MyFinanceFlows/GoalsFlow"),
        .package(path: "../TabBarFeature"),
        .package(path: "../WelcomeFeature"),
        .package(path: "../SavingsListFeature"),
        .package(path: "../SavingsDetailsFeature"),
        .package(path: "../AddSavingsFeature"),
        .package(path: "../FirebaseFramework"),
        .package(path: "../Listeners"),
        .package(path: "../MyFinanceDomain")
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                "AppState",
                "RootFeature",
                "AuthFlow",
                "DepositsFlow",
                "GoalsFlow",
                "TabBarFeature",
                "WelcomeFeature",
                "SavingsListFeature",
                "SavingsDetailsFeature",
                "AddSavingsFeature",
                "FirebaseFramework",
                "Listeners",
                "MyFinanceDomain"
            ]),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]),
    ]
)
