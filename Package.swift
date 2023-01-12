// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Crossmint",
    products: [
        .library(
            name: "Crossmint",
            targets: ["Crossmint"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Crossmint",
            dependencies: []
        ),
    ]
)
