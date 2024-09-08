// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Home", targets: ["Home"])
    ],
    dependencies: [
        .package(path: "../Libs/HTTPClient"),
        .package(path: "../Libs/UIUtils"),
        .package(path: "../Libs/SharedDomain"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Home", dependencies: ["UIUtils", "SharedDomain", "HTTPClient"]),
        .testTarget(name: "HomeTests", dependencies: ["Home"])
    ]
)
