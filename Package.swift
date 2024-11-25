// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "CrappKit",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(name: "CrappKit", targets: ["CrappKit"])
    ],
    targets: [
        .target(name: "CrappKit")
    ]
)
