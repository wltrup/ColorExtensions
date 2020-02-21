// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ColorExtensions",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v10),
        .watchOS(.v5),
        .tvOS(.v10)
    ],
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
