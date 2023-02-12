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
        .package(path: "../TabBarFeature"),
        .package(path: "../WelcomeFeature"),
        .package(path: "../SavingsListFeature"),
        .package(path: "../SavingsDetailsFeature"),
        .package(path: "../AddSavingsFeature"),
        .package(path: "../DepositsListFeature"),
        .package(path: "../DepositsDetailsFeature"),
        .package(path: "../GoalsListFeature"),
        .package(path: "../GoalDetailsFeature"),
        .package(path: "../AddGoalFeature"),
        .package(path: "../EditGoalFeature"),
        .package(path: "../AddGoalStepFeature"),
        .package(path: "../EditGoalStepFeature"),
        .package(path: "../FirebaseFramework"),
        .package(path: "../Listeners"),
        .package(path: "../MyFinanceDomain"),
        .package(path: "../AddDepositFeature"),
        .package(path: "../AddDepositStepFeature")
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                "AppState",
                "RootFeature",
                "AuthFlow",
                "TabBarFeature",
                "WelcomeFeature",
                "SavingsListFeature",
                "SavingsDetailsFeature",
                "AddSavingsFeature",
                "DepositsListFeature",
                "DepositsDetailsFeature",
                "GoalsListFeature",
                "GoalDetailsFeature",
                "AddGoalFeature",
                "EditGoalFeature",
                "AddGoalStepFeature",
                "EditGoalStepFeature",
                "FirebaseFramework",
                "Listeners",
                "MyFinanceDomain",
                "AddDepositFeature",
                "AddDepositStepFeature"
            ]),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]),
    ]
)
