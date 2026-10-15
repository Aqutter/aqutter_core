// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aqutter_core",
    platforms: [
        .iOS("15.0"),
    ],
    products: [
        .library(name: "aqutter-core", targets: ["aqutter_core"])
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-collections.git", from: "1.2.1")
    ],
    targets: [
        .target(
            name: "aqutter_core",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
