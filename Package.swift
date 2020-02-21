// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ColorExtensions",
    products: [
        .library(
            name: "ColorExtensions",
            targets: ["ColorExtensions"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ColorExtensions",
            dependencies: []
        ),
        .testTarget(
            name: "ColorExtensionsTests",
            dependencies: ["ColorExtensions"]
        ),
    ]
)
