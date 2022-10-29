// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CrappKit",
    products: [
        .library(
            name: "CrappKit",
            targets: ["CrappKit"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CrappKit",
            dependencies: []
        ),
        .testTarget(
            name: "CrappKitTests",
            dependencies: ["CrappKit"]
        )
    ]
)
