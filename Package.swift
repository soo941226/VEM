// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "VEM",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "VEM", targets: ["VEM"])
    ],
    targets: [
        .target(name: "VEM", path: "./Core")
    ],
    swiftLanguageVersions: [.v5]
)
