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
        .package(path: "../WelcomeFeature"),
        .package(path: "../SavingsListFeature"),
        .package(path: "../SavingsDetailsFeature"),
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
//        .package(path: "../EditDepositFeature"),
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
                "WelcomeFeature",
                "SavingsListFeature",
                "SavingsDetailsFeature",
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
//                "EditDepositFeature"
            ]),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]),
    ]
)
