// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWTouchEffectButton",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWTouchEffectButton", targets: ["WWTouchEffectButton"]),
    ],
    targets: [
        .target(name: "WWTouchEffectButton", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
