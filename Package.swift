// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable all

import PackageDescription

let package = Package(
    name: "OversizeUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "OversizeUI", targets: ["OversizeUI"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "OversizeUI", dependencies: [], resources: [.process("Resources")]),
        .testTarget(name: "OversizeUITests", dependencies: ["OversizeUI"]),
    ]
)
