// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VGHtmlParser",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VGHtmlParserDynamic",
        //    type: .dynamic,
            targets: ["VGHtmlParser"]
        ),
        .library(
            name: "VGHtmlParserStatic",
         //   type: .static,
            targets: ["VGHtmlParser"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "VGHtmlParser",
            dependencies: [],
            path: "VGHtmlParser",
            exclude: [
                "Dependencies/hpple/README.markdown",
                "Dependencies/hpple/LICENSE.txt"
            ],
            sources: ["Classes", "Dependencies"],
           // publicHeadersPath: "Classes/VGHtmlParser/VGHtmlParser.h",
            cSettings: [
                .headerSearchPath("Classes/**"),
                .headerSearchPath("Dependencies/**")
            ]
        )
    ]
)
