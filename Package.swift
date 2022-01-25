// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PenguinStatisticsRecognizer",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_14),
        .macCatalyst(.v14),
        .tvOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PenguinStatisticsRecognizer",
            targets: ["PenguinStatisticsRecognizer"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(name: "opencv2", path: "opencv2.xcframework"),
        .target(
            name: "PenguinStatisticsRecognizerCPP",
            dependencies: ["opencv2"],
            linkerSettings: [
                .linkedFramework("Accelerate"),
                .linkedFramework("OpenCL", .when(platforms: [.macOS]))
            ]
        ),
        .target(
            name: "PenguinStatisticsRecognizer",
            dependencies: ["PenguinStatisticsRecognizerCPP"],
            resources: [.process("data")]
        ),
        .testTarget(
            name: "PenguinStatisticsRecognizerTests",
            dependencies: ["PenguinStatisticsRecognizer"],
            exclude: [
                "test_image/1024x768",
                "test_image/err",
            ],
            resources: [.process("test_image/test")]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
