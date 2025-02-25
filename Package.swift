// swift-tools-version:5.9
import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "CobrowseSDK",
    platforms: [
        .macOS(.v10_15), .iOS(.v13)
    ],
    products: [
        .library(
            name: "CobrowseSDK",
            targets: ["CobrowseSDK"]),
        
        .library(
            name: "CobrowseMacros",
            targets: ["CobrowseMacros"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ],
    targets: [
        .target(
            name: "CobrowseMacros",
            dependencies: [ "CobrowseRedaction" ]
        ),
        
        .macro(
            name: "CobrowseRedaction",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        
        .testTarget(
            name: "CobrowseMacrosTests",
            dependencies: [
                "CobrowseMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
        
        .binaryTarget(
            name: "CobrowseSDK",
            path: "CobrowseSDK.xcframework"
        ),
    ]
)
