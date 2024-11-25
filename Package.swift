// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CrappKit",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(name: "CrappKit", targets: ["CrappKit"])
    ],
    targets: [
        .target(name: "CrappKit"),
        .testTarget(name: "CrappKitTests", dependencies: ["CrappKit"])
    ]
)
