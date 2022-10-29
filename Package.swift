// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "DeclarativeAppKit",
    products: [
        .library(
            name: "DeclarativeAppKit",
            targets: ["DeclarativeAppKit"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "DeclarativeAppKit",
            dependencies: []),
        .testTarget(
            name: "DeclarativeAppKitTests",
            dependencies: ["DeclarativeAppKit"]),
    ]
)
